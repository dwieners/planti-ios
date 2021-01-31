//
//  AvatarHeaderView.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import SwiftUI

struct AvatarHeaderView: View {
    
    var name: String
    var score: Int
    
    var body: some View {
        VStack{
            HStack {
            Text(name)
                .font(.headline)
                Spacer()
                ScoreView(value: score)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct AvatarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarHeaderView(name: "Albus Dumbledore", score: 10).previewAsComponent()
    }
}
