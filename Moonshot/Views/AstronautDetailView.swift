//
//  AstronautDetailView.swift
//  Moonshot
//
//  Created by Mert Ali Hanbay on 26.08.2023.
//

import SwiftUI

struct AstronautDetailView: View {
    let astronaut : Astronaut
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }.background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautDetailView_Previews: PreviewProvider {
    static let astronauts : [String : Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautDetailView(astronaut: astronauts["grissom"]!)
            .preferredColorScheme(.dark)
    }
}
