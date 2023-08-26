//
//  ContentView.swift
//  Moonshot
//
//  Created by Mert Ali Hanbay on 22.08.2023.
//

import SwiftUI

struct ContentView: View {

    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var isGrid = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: isGrid ? 150: 1000))]) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionDetailView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }.padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                            }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }.padding()
                    .padding([.horizontal, .bottom])
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Moonshot")
                        .font(.title.bold())
                        .accessibilityAddTraits(.isHeader)
                        .padding(.top)

                }
                    ToolbarItem {
                        Button {
                            withAnimation {
                                isGrid.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "aspectratio")
                        }.padding(.top)

                    }
            }.background(.darkBackground)
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
