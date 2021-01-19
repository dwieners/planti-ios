//
//  LoginView.swift
//  Planti
//
//  Created by Dominik Wieners on 19.01.21.
//

import SwiftUI




struct LoginView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    @ObservedObject private var userViewModel = UserViewModel()
    
    @Binding var activeSheet: Sheet?
    

    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        NavigationView{
            List{
                TextField("Username", text: $userViewModel.user.username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $userViewModel.user.password)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .listStyle(GroupedListStyle())
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = nil
                    }, label: {
                        Image(systemName: "xmark")
                    }),
                trailing:
                    Button(action: {
                      loginViewModel.login(username: userViewModel.user.username, password: userViewModel.user.password)
                    }, label: {
                        Text("Anmelden")
                    }))
            .navigationBarTitle("Login")
        }
        .onReceive(loginViewModel.$token){ token in
            if let token = token {
                self.authViewModel.token = token
            }
        }
        .accentColor(.green)
        .alert(item: $loginViewModel.loginAlerts) { item in
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
            case .userDosentExist:
                return Alert(
                    title: Text("Diser Nutzer existiert nicht"),
                    dismissButton: .default(Text("OK")))
            case .wrongPassword:
                return Alert(
                    title: Text("Dein Passwort ist falsch"),
                    dismissButton: .default(Text("OK")))
            }
        }
       
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(activeSheet: .constant(nil))
            .environmentObject(AuthViewModel())
            .environmentObject(LoginViewModel())
    }
}
