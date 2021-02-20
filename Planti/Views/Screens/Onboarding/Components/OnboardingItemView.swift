//
//  OnboardingItemView.swift
//  Planti
//
//  Created by Dominik Wieners on 18.02.21.
//

import SwiftUI

struct OnboardingItemView: View {
    
    @Binding var activeSheet: Sheet?
    
    var image: Image
    
    var title: String
    
    var description: String?
    
    var hasDismiss: Bool
    
    var body: some View {
        VStack {
            image.resizable().scaledToFit().padding(32)
            
            VStack(alignment: .leading) {
                Text(title).font(.title).bold()
                Spacer().frame(height: 32)
                if let description = description {
                    Text(description).font(.title2)
                }
                if hasDismiss {
                    Spacer().frame(height: 32)
                    LazyVStack{
                        Button(action: {
                            UserDefaults.standard.set(true, forKey: "onboarding_done")
                            activeSheet = nil
                        }, label: {
                            Text("Los geht's")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .mask(Capsule())
                        })
                    }.frame(maxWidth: .infinity)
                }
            }.padding(32).padding()
            
            Spacer()
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct OnboardingItemView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingItemView(activeSheet: .constant(nil), image: Image("magic-wand"), title: "Werde Krätuerzuaberer oder Kräuterhexe", description: "Entwickle deinen eigenen Avatar und messe dich mit deinen Freunden.", hasDismiss: false)
    }
}
