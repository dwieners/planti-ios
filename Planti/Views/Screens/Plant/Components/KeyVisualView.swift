//
//  KeyVisualView.swift
//  Planti
//
//  Created by Dominik Wieners on 26.01.21.
//

import SwiftUI
import Kingfisher

struct KeyVisualView: View {
    
    var imageUrl:String
  
    var body: some View {
        KFImage(URL(string: imageUrl)!)
            .resizable()
            .scaledToFit()
    }
}

struct KeyVisualView_Previews: PreviewProvider {
    static var previews: some View {
        KeyVisualView(imageUrl: "http://64.227.119.182:5000/api/plants/images/bellis_perennis")
    }
}
