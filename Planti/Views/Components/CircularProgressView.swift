//
//  CircularProgressView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.01.21.
//

import SwiftUI

struct CircularProgressView: View {
    
    var color: Color
    var currentData: CGFloat
    var goal: CGFloat
    var font: Font = .system(size: 22)
    
    func getPercent(current : CGFloat,goal : CGFloat)->String{
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0, to: 1)
                .stroke(color.opacity(0.05), lineWidth: 10)
                .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
            
            Circle()
                .trim(from: 0, to: (currentData / goal))
                .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
            
            Text(getPercent(current: currentData, goal: goal) + " %")
                .font(font)
                .fontWeight(.bold)
                .foregroundColor(color)
                .rotationEffect(.init(degrees: 90))
        }
        .rotationEffect(.init(degrees: -90))
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(color: .green, currentData: 50, goal: 100, font: .system(size: 22))
            .previewAsComponent()
    }
}
