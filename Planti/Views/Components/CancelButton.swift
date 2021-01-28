//
//  CancelButton.swift
//  Planti
//
//  Created by Dominik Wieners on 28.01.21.
//

import SwiftUI

struct CancelButton: View {
    
    var action: () -> Void
    
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "xmark")
                .imageScale(.large)
                .frame(width: 44, height: 44, alignment: .leading)
        })
        
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CancelButton(action: {})
    }
}
