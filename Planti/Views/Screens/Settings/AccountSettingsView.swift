//
//  AccoutSettingsView.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI
import SwiftKeychainWrapper

enum AccountSettingsViewAlert: Identifiable {
    var id: Int {
        self.hashValue
    }
    case not_available
}



struct AccountSettingsView: View {
    
    @Binding var activeSheet: Sheet?
    @EnvironmentObject var auth: AuthViewModel
    @State private var accountSettingsViewAlert: AccountSettingsViewAlert?
    
    var body: some View {
        List{
            Section(header: Text("Profil")){
                HStack{
                    LazyVStack(alignment: .trailing){
                        Text("Nutzername").foregroundColor(.green)
                    }.frame(width: 120)
                    Text("Max").lineLimit(0)
                }
                HStack{
                    LazyVStack(alignment: .trailing){
                    Text("Benutzerkonto").foregroundColor(.green)
                    }.frame(width: 120)
                    Text("max.mustermann@test.de").lineLimit(0)
                }
            }
            Section(header: Text("Passwort")){
                Button(action: {
                    accountSettingsViewAlert = .not_available
                }, label: {
                    LazyVStack{
                        Text("Passwort zurücksetzen").foregroundColor(.green)
                    }
                })
            
            }
            Section(header: Text("Konto")){
                Button(action: {
                    activeSheet = nil
                    auth.resetAuth()
                }, label: {
                    LazyVStack{
                        Text("Abmelden").foregroundColor(.green)
                    }
                })
               
                Button(action: {
                    accountSettingsViewAlert = .not_available
                }, label: {
                    LazyVStack{
                        Text("Konto löschen").foregroundColor(.red)
                    }
                })
              
            }
        }
        .alert(item: $accountSettingsViewAlert, content: { (item) -> Alert in
            switch(item){
                case .not_available:
                    return Alert(title: Text("Diese Funktion gibt es noch nicht."),
                                 dismissButton: .default(Text("OK")))
            }
        })
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Benutzerkonto")
    }
    
}

struct AccoutSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountSettingsView(activeSheet: .constant(.settings))
        }.previewAsScreen()
    }
}
