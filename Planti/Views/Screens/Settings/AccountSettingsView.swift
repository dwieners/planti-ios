//
//  AccoutSettingsView.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct AccountSettingsView: View {
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
                LazyVStack{
                    Text("Abmelden").foregroundColor(.green)
                }
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
            AccountSettingsView()
        }.previewAsScreen()
    }
}
