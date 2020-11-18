//
//  VideoClassifiyerView.swift
//  Planti
//
//  Created by Dominik Wieners on 18.11.20.
//

import SwiftUI
import CoreML
import UIKit
import Vision

struct VideoClassifiyerView: View {
 
    @State private var results: [VNClassificationObservation] = []
    

    var body: some View {
        ZStack {
            CameraView(results: $results)
            ResultText()
                .padding(.all)
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(8)
        
        }.navigationBarTitle("Kamera", displayMode: .inline)
    }
    
    
    func ResultText() -> Text {
        if let result = results.first {
            return Text(result.identifier)
        }else{
            return Text("🔎")
        }
    }
}

struct VideoClassifiyerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoClassifiyerView()
    }
}
