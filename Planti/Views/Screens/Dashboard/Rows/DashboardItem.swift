//
//  DashboardViewItem.swift
//  Planti
//
//  Created by Dominik Wieners on 01.01.21.
//

import SwiftUI

struct DashboardItem: View {
    
    var title:String
    var image: Image
    var small: Bool = false
    
    
    var body: some View {
        if small {
            LazyVStack(alignment: .center){
                VStack{
                    Text(title).font(.headline)
                    Spacer().frame(height:16)
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 58)
                }
            }
            .foregroundColor(.label)
            .cardContained()
            .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
        }else{
            LazyVStack(alignment: .leading){
                HStack(alignment: .top){
                    Text(title).font(.headline)
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 58)
                }
            }
            .foregroundColor(.label)
            .cardContained()
            .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
        }
    }
}

struct DashboardViewItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardItem(title: "Pflanzenübersicht", image: Image(systemName: "tray.2.fill"))
                .previewAsComponent()
            
            DashboardItem(title: "Rangliste", image: Image(systemName: "rosette"), small: true)
                .previewAsComponent()
            
        }
    }
}
