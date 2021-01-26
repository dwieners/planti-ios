//
//  AccoutSettingsView.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI
import SwiftKeychainWrapper

struct AccountSettingsView: View {
    
    @Binding var activeSheet: Sheet?
    @EnvironmentObject var auth: AuthViewModel
    
    
    var body: some View {
        List{
            Section(header: Text("Profil")){
                HStack{
                    LazyVStack(alignment: .trailing){
                        Text("Nutzername").foregroundColor(.green)
                    }.frame(width: 120)
                    Text("Dominik").lineLimit(0)
                }
                HStack{
                    LazyVStack(alignment: .trailing){
                    Text("Benutzerkonto").foregroundColor(.green)
                    }.frame(width: 120)
                    Text("dom.wieners@gmx.net").lineLimit(0)
                }
            }
            Section(header: Text("Passwort")){
                LazyVStack{
                    Text("Passwort zurücksetzen").foregroundColor(.green)
                }
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
               
                LazyVStack{
                    Text("Konto löschen").foregroundColor(.red)
                }
            }
        }
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
