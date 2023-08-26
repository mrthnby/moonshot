//
//  MissionDetailView.swift
//  Moonshot
//
//  Created by Mert Ali Hanbay on 25.08.2023.
//

import SwiftUI

struct MissionDetailView: View {
    let mission: Mission
    let crew: [CrewMember]

    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map({ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        })
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {

                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    if(mission.formattedLaunchDate != "N/A"){
                        Text(mission.formattedLaunchDate).padding()
                    }
                    
                    
                    VStack(alignment: .leading) {

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(crew, id: \.role) { crew in
                                    NavigationLink {
                                        AstronautDetailView(astronaut: crew.astronaut)
                                    } label: {

                                        HStack {
                                            Image(crew.astronaut.id)
                                                .resizable()
                                                .frame(width: 104, height: 72)
                                                .clipShape(Capsule())
                                                .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                            VStack(alignment: .leading) {
                                                Text(crew.astronaut.name)
                                                    .foregroundColor(.orange)
                                                    .font(.headline)

                                                Text(crew.role)
                                                    .foregroundColor(.secondary)
                                            }.padding(.trailing)
                                        }
                                    }
                                }
                            }
                        }
                        CustomDivider()
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)


                    }
                        .padding(.horizontal)

                }
                    .padding(.bottom)
            }
        }.navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

struct MissionDetailView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionDetailView(mission: missions[2], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
