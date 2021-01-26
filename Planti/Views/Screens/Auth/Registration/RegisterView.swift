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
    @Binding var figureType: FigureOption
    
    var body: some View {
        
        VStack{
            List{
                Section(header: Text("Nutzer")){
                    TextField("Nutzername", text: $registrationViewModel.username)
                        .textContentType(.username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                }
                Section(header: Text("Passwort")){
                    SecureField("Passwort", text: $registrationViewModel.password)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Passwort wiederholen", text: $registrationViewModel.password)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
            }.listStyle(GroupedListStyle())
          
        }
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
                    title: Text("Der User \(registrationViewModel.username) existiert bereits"),
                    dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarTitle("Nutzer erstellen", displayMode: .large)
        .navigationBarItems(
            trailing:
                Button(action: {
                    registrationViewModel.register(
                        username: registrationViewModel.username,
                        password: registrationViewModel.password,
                        figureType: figureType.type
                    )
                }, label: {
                    Text("Registrieren")
                    
                })
        )
    }
    
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrationView(
                activeSheet: .constant(.register),
                figureType: .constant(FigureOption(title: "Hexe", type: .WITCH))
            ).environmentObject(AuthViewModel())
            .environmentObject(RegistrationViewModel())
        }
        
    }
}
