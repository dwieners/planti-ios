//
//  ScoreView.swift
//  Planti
//
//  Created by Dominik Wieners on 31.01.21.
//

import SwiftUI

struct ScoreView: View {
    
    var value: Int
    
    var body: some View {
        Text("\(value) Punkte")
            .font(.body)
            .bold()
            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.vertical, 8)
            .background(Color.yellow)
            .foregroundColor(.black)
            .cornerRadius(10)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(value: 10)
    }
}
