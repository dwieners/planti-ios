//
//  ArchivementItemView.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import SwiftUI

struct AchievementItemView: View {
    
    
    var name: String
    var type: AchievementType
   
    
    var body: some View {
        VStack(spacing: 0){
            getImage(by: type)
                .resizable()
                .scaledToFit()
                .padding()
         
            Text(name)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.systemBackground.opacity(0.5))
               
        }
        .frame(height: 150)
        .background(Color.secondarySystemBackground)
        .cornerRadius(10)
    }
}

struct AchievementItemView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementItemView(name: "Hörner", type: .HORNS_HAT).previewAsComponent()
    }
}
