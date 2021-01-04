//
//  LoginView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI

struct LoginView: View {
    
    //@EnvironmentObject var auth: AuthViewModel
    
    @State var showingDetail = false
    
    var body: some View {
            VStack{
                Spacer()
                Text("Finde heraus, was in deiner Gegend wächst und gedeit.").font(.largeTitle).bold()
                Spacer().frame(height: 32)
                Button(action: {self.showingDetail.toggle()}, label: {
                    Text("Account erstellen")
                }).buttonStyle(ActionButtonStyle())
                Spacer().frame(height: 16)
                Spacer()
                HStack(spacing: 6){
                    Text("Hast bereits einen Accout?").foregroundColor(Color.label.opacity(0.8))
                    Button(action: {
                        print("Hallo")
                    }, label: {
                        Text("Anmelden")
                    })
                }
            }.padding()
            .sheet(isPresented: $showingDetail) {
                RegisterView(showModal: self.$showingDetail)
            }
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
