//
//  ProfilView.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI

struct AvatarView: View {
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        NavigationView{
            Text("🚧 Hier wird noch gebaut")
                .navigationBarTitle("Dein Avatar")
                .navigationBarItems(
                    leading:
                        Button(
                            action: {
                                activeSheet = nil
                            },
                            label: {
                                Text("Schließen").foregroundColor(.green)
                            }
                        )
                )
        }
        
        
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(activeSheet: .constant(.avatar))
    }
}
