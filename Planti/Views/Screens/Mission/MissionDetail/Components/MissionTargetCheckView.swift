//
//  MissionTargetCheckView.swift
//  Planti
//
//  Created by Dominik Wieners on 31.01.21.
//

import SwiftUI

struct MissionTargetCheckView: View {
    
    
    var title: String
    var isChecked: Bool
 
    
    var body: some View {
        if isChecked {
        HStack {
            Image("check-mark")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .padding(.trailing, 8)
            
            Text(title)
            Spacer()
        }.padding(.vertical)
        }else{
        HStack {
            Spacer()
                .frame(width: 32, height: 32)
                .background(Color.gray.opacity(0.2))
                .mask(Circle())
                .padding(.trailing, 8)
            
            
            Text(title)
            Spacer()
        }.padding(.vertical)
        }
    }
}

struct MissionTargetCheckView_Previews: PreviewProvider {
    static var previews: some View {
        MissionTargetCheckView(title: "Finde ein Gänseblümchen", isChecked: true)
    }
}
