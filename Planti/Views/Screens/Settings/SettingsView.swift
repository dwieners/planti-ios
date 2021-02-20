//
//  SettingsView.swift
//  Planti
//
//  Created by Dominik Wieners on 02.01.21.
//

import SwiftUI


enum SettingsViewAlert: Identifiable {
    var id: Int {
        self.hashValue
    }
    case not_available
}


struct SettingsView: View {
    
    @Binding var activeSheet: Sheet?
    @State private var alertSheet: Sheet?
    @State private var settingsViewAlert: SettingsViewAlert?
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Über")){
                    NavigationLink(
                        destination:Text("🚧 Hier wird noch gebaut."),
                        label: {
                            Text("Datenschutz")
                        })
                    NavigationLink(
                        destination: Text("🚧 Hier wird noch gebaut."),
                        label: {
                            Text("Impressum")
                        })
                }
                Section(header: Text("Einstellungen")){
                    NavigationLink(
                        destination: AccountSettingsView(activeSheet: $activeSheet),
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
            .alert(item: $settingsViewAlert, content: { (item) -> Alert in
                switch(item){
                case .not_available:
                    return Alert(title: Text("Diese Funktion gibt es noch nicht."),
                                 dismissButton: .default(Text("OK")))
                }
            })
            .actionSheet(item: $alertSheet) { item in
                ActionSheet(title: Text("Sprache überschreiben"),
                            message: nil,
                            buttons: [.default(Text("Deutsch 🇩🇪"), action: {
                                alertSheet = nil
                            }),
                            .default(Text("Englisch 🇬🇧"), action: {
                                alertSheet = nil
                                settingsViewAlert = .not_available
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
