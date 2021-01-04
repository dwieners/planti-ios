//
//  ProfilView.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI

struct ProfilView: View {
    
    @Binding var actionSheet: Sheet?
    
    var body: some View {
        NavigationView{
            Text("Avatar")
                .navigationBarTitle("Dein Avatar")
                .navigationBarItems(
                    leading:
                        Button(
                            action: {
                                actionSheet = nil
                            },
                            label: {
                                Image(systemName: "xmark").foregroundColor(.green)
                            }
                        )
                )
        }
        
        
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        
        ProfilView()
    }
}
