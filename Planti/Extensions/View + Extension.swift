//
//  View + Extension.swift
//  Planti
//
//  Created by Dominik Wieners on 18.11.20.
//

import SwiftUI


struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    
    func cardContained(background: Color = Color.secondarySystemBackground, cornerRadius: CGFloat = 8) -> some View {
        self
            .padding(.all)
            .background(background)
            .cornerRadius(cornerRadius)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    
    /// Modifier for adding SearchBar to SwiftUI NavigationBar
    /// - Parameter searchBar: SeachBar
    /// - Returns: Modifier
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
    
}
