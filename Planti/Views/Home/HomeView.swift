//
//  HomeView.swift
//  Planti
//
//  Created by Dominik Wieners on 17.11.20.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showModalView = false

    
    var body: some View {
        NavigationView{
            ScrollView {
                NavigationLink(
                    destination: VideoClassifiyerView()
                ){
                    VStack(alignment: .leading, spacing: 16) {
                        HStack{
                            Text("Failed to retrieve total cases count")
                        }.frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .cardContained()
                    .padding()
                }
                .navigationTitle(Text("Planti"))
                .navigationBarItems(
                    leading:
                        Button(action: {
                            showModalView.toggle()
                        }, label: {
                            Image(systemName: "person.circle.fill")
                        }),
                    trailing:
                        Button(action: {
                            showModalView.toggle()
                        }, label: {
                            Image(systemName: "gear")
                        })
                    
                )
            }
            
        }
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
