//
//  RegisterView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Binding var showModal: Bool
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(header: Text("Profil")){
                        TextField("Username", text: $userViewModel.user.username)
                        
                    }
                    Section(header: Text("Deine Email")){
                        TextField("EMail", text: $userViewModel.user.email)
                        
                    }
                    Section(header: Text("Password")){
                        TextField("Password", text: $userViewModel.user.password)
                        TextField("Password wiederholen", text: $userViewModel.user.password)
                    }
                    
                }.listStyle(GroupedListStyle())
            }.navigationBarTitle("Account erstellen", displayMode: .large)
            .navigationBarItems(
                leading:
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                        
                    }),
                trailing: Button(action: {
                   // showModal.toggle()
                    auth.register(username: userViewModel.user.username, password: userViewModel.user.password)
                    // auth.login()
                }, label: {
                    Text("Anmelden")
                    
                })
            )
            
        }.accentColor(.green)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showModal: .constant(true))
    }
}
