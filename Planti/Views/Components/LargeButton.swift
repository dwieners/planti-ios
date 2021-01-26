//
//  LargeButton.swift
//  Planti
//
//  Created by Dominik Wieners on 25.01.21.
//

import SwiftUI

struct LargeButton: View {
    
    let label:String
    let action: () -> Void
    

    var body: some View {
        
        Button(action: action) {
            Text(label)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(height: 100)
        .background(Color.tertiarySystemBackground)
        .foregroundColor(.green)
        .cornerRadius(10)
        .font(.system(size: 22, weight: .bold, design: .default))
        

        
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(label: "Hallo", action: {})
    }
}
