//
//  HomeView.swift
//  Planti
//
//  Created by Dominik Wieners on 17.11.20.
//

import SwiftUI

struct TestView: View {
    
    @State private var showModalView = false

    
    var body: some View {
        NavigationView{
            ScrollView {
                NavigationLink(
                    destination: CameraLiveView()
                ){
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack{
                            Text("Kamera Live").foregroundColor(.white)
                        }.frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .cardContained(background: .green, cornerRadius: 8)
                    .padding([.top, .horizontal])
                    
                }
                NavigationLink(
                    destination: ImageSelectionView()
                ){
                    VStack(alignment: .leading, spacing: 16) {
                        HStack{
                            Text("Gallerie & Kamera")
                        }.frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .cardContained()
                    .padding([.top, .horizontal])
                }
                NavigationLink(
                    destination: Text("Test")
                ){
                    VStack(alignment: .leading, spacing: 16) {
                        HStack{
                            Text("Rest API")
                        }.frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .cardContained()
                    .padding([.top, .horizontal])
                }
                .navigationTitle(Text("Home"))
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


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
