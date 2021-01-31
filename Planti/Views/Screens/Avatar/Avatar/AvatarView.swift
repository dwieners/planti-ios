//
//  AvatarView.swift
//  Planti
//
//  Created by Dominik Wieners on 29.01.21.
//

import SwiftUI

struct AvatarView: View {
    
    @ObservedObject var avatarViewModel = AvatarViewModel()
    @Binding var activeSheet: Sheet?
    
    func cancleAction() {
        self.activeSheet = nil
    }
    
    func loadingAction() {
        self.avatarViewModel.loadAvatar()
    }
    
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var data = [
        MyAchievementItem(id: 0, name: "Standard", description: "Blub", type: .STANDARD),
        MyAchievementItem(id: 1, name: "Hörner", description: "Blub", type: .HORNS_HAT)
    ]
    
    
    
    
    var body: some View {
        NavigationView{
            VStack {
                if let myAvatar = avatarViewModel.myAvatar {
                    ScrollView{
                        VStack {
                            VStack {
                                AvatarHeaderView(name: myAvatar.avatar_name, score: myAvatar.score)
                                AvatarKeyVisual(figureType: myAvatar.figure_type)
                                
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        VStack{
                            HStack {
                                Text("Deine Erungenschaften")
                                    .font(.headline)
                                Spacer()
                                NavigationLink(
                                    destination: InventoryView(score: myAvatar.score),
                                    label: {
                                        Text("Inventar anzeigen").bold()
                                    })
                            }.padding()
                            LazyVGrid(columns: columns, spacing: 20){
                                ForEach(myAvatar.achievements) { item in
                                    AchievementItemView(name: item.name, type: item.type)
                                }
                            }.padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    PlantiIndicatorView()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("Avatar"))
            .navigationBarItems(leading: CancelButton(action: cancleAction) )
            
            
        }.accentColor(.green)
        .onAppear(perform: loadingAction)
        
        
    }
}

//struct AvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarView(activeSheet: .constant(nil))
//            .environmentObject(AvatarViewModel())
//    }
//}
