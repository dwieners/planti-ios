//
//  MissionView.swift
//  Planti
//
//  Created by Dominik Wieners on 04.01.21.
//

import SwiftUI

struct Mission : Identifiable {
    
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}

var stats_Data = [
    
    Mission(id: 0, title: "Tee", currentData: 6.8, goal: 15, color: .blue),
    
    Mission(id: 1, title: "Heilkräuter", currentData: 3.5, goal: 5, color: .green),
     
    Mission(id: 3, title: "Gewürze", currentData: 6.2, goal: 10, color: .yellow),
    
    Mission(id: 4, title: "Pilze", currentData: 12.5, goal: 25, color: .orange),
    
    Mission(id: 5, title: "Blüten", currentData: 16889, goal: 20000, color: .purple),
]

struct MissionView: View {
    
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
 
    
    // calculating percent...
    
    func getPercent(current : CGFloat,goal : CGFloat)->String{
        
        let per = (current / goal) * 100
        
        return String(format: "%.1f", per)
    }
    
    // calculating Hrs For Height...
    
    func getHeight(value : CGFloat)->CGFloat{
        
        // the value in minutes....
        // 24 hrs in min = 1440
        
        let hrs = CGFloat(value / 1440) * 200
        
        return hrs
    }
    
    // getting hrs...
    
    func getHrs(value: CGFloat)->String{
        
        let hrs = value / 60
        
        return String(format: "%.1f", hrs)
    }
    
   
    
    // converting Number to decimal...
    
    func getDec(val: CGFloat)->String{
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        return format.string(from: NSNumber.init(value: Float(val)))!
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVGrid(columns: columns,spacing: 30){
                    
                    ForEach(stats_Data){stat in
                            MissionItem(mission: stat)
                    }
                }
                .padding()
                .navigationBarTitle("Missionen")
           
            }
        }
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MissionView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .previewAsScreen()
    }
}
