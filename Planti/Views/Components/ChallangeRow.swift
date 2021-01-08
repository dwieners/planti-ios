//
//  ChallangeRow.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI

struct ChallangeRow: View {
    var iconName: String
    var iconColor: Color
    var title: String
    var hasDivder: Bool = true
    var hasChevron: Bool = true
    
    var body: some View {
        HStack {
            
                Image(systemName: iconName)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(iconColor)
                    .cornerRadius(8.0)
                    .padding(.trailing, 8)
            VStack(alignment: .leading){
                    Text(title)
            }
        }
    }
}

struct ChallangeRow_Previews: PreviewProvider {
    static var previews: some View {
        ChallangeRow(iconName: "message.fill", iconColor: Color.purple, title: "Quiz")
    }
}
