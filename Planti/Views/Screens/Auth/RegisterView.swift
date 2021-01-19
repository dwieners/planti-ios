//
//  RegistrationView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI
import SwiftKeychainWrapper


struct RegistrationView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var registrationViewModel: RegistrationViewModel
    
    @ObservedObject var userViewModel = UserViewModel()
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(header: Text("User")){
                        TextField("Username", text: $userViewModel.user.username)
                            .textContentType(.username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                    }
                    Section(header: Text("Password")){
                        SecureField("Password", text: $userViewModel.user.password)
                            .textContentType(.password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Password wiederholen", text: $userViewModel.user.password)
                            .textContentType(.password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                }.listStyle(GroupedListStyle())
            }.navigationBarTitle("Account erstellen", displayMode: .large)
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = nil
                    }, label: {
                        Image(systemName: "xmark")
                    }),
                trailing: Button(action: {
                       registrationViewModel.register(
                        username: userViewModel.user.username,
                        password: userViewModel.user.password
                       )
                }, label: {
                    Text("Registrieren")
                    
                })
            )
        }
        .accentColor(.green)
        .onReceive(registrationViewModel.$token){ token in
            if let token = token {
                authViewModel.token = token
            }
        }
        .alert(item: $registrationViewModel.registrationSheet) { item in
            switch (item) {
            case .emptyUsernameOrPassword:
                return  Alert(
                    title: Text("Dein Username oder Passwort sind leer"),
                    dismissButton: .default(Text("OK")))
            case .shortPasswort:
                return Alert(
                    title: Text("Passwort zu kurz!?"),
                    message: Text("Dein Passwort muss mindestens 8 Zeichen betragen"),
                    dismissButton: .default(Text("OK")))
            case .userAlreadyExist:
                return Alert(
                    title: Text("Der User \(userViewModel.user.username) existiert bereits"),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(activeSheet: .constant(.register))
            .environmentObject(AuthViewModel())
            .environmentObject(RegistrationViewModel())
    }
}
