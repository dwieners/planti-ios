//
//  InvalidPredictionView.swift
//  Planti
//
//  Created by Dominik Wieners on 28.01.21.
//

import SwiftUI

struct InvalidPredictionView: View {
    
    @Binding var selectionSheet: SelectionSheet?
    
    func cancelAction() {
        selectionSheet = nil
    }
    
    var cancelButton: some View {
        CancelButton(action: cancelAction)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("sadness")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .padding()
                Text("Das ist keine Pflanze")
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(.label)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(leading: cancelButton)
        }
        .accentColor(.green)
    }
}

struct InvalidPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        InvalidPredictionView(selectionSheet: .constant(nil))
    }
}
