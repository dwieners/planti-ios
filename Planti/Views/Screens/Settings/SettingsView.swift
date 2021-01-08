//
//  SettingsView.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var activeSheet: Sheet?
    
    @State private var alertSheet: Sheet?
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Über")){
                    Text("Datenschutz")
                    Text("Impressum")
                }
                Section(header: Text("Einstellungen")){
                    NavigationLink(
                        destination: AccountSettingsView(),
                        label: {
                            Text("Benutzerkonto")
                        })
                    Button(action: {
                        alertSheet = .speech
                    }, label: {
                        Text("Systemsprache überschreiben").foregroundColor(.green)
                    })
                }
            }.listStyle(GroupedListStyle())
            .navigationTitle("Einstellungen")
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = nil
                    }, label: {
                        Text("Schließen")
                    }
                    )
            )
            .actionSheet(item: $alertSheet) { item in
                    ActionSheet(title: Text("Sprache überschreiben"),
                                message: nil,
                                buttons: [.default(Text("Deutsch 🇩🇪"), action: {
                                    alertSheet = nil
                                }),
                                .default(Text("Englisch 🇬🇧"), action: {
                                    alertSheet = nil
                                })
                                ])
            }
            
            
            
        }.accentColor(.green)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activeSheet: .constant(.settings)).previewAsScreen()
    }
}
