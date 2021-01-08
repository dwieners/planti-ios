//
//  SelectionDashBoardView.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI


struct PlantShape: Identifiable {
    var id = UUID()
    var title: String
    var keyVisual: String
}


struct PredictionDashboardView: View {
    
    @Binding var activeSheet: Sheet?
    
    let data = [
        PlantShape(title: "Blüte", keyVisual: "flower"),
        PlantShape(title: "Blatt", keyVisual: "leaf"),
        PlantShape(title: "Frucht", keyVisual: "fruit"),
        PlantShape(title: "Rinde", keyVisual: "bark")
    ]
  
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16),
        GridItem(.flexible(minimum: 100, maximum: 200)),
    ]
    
    var body: some View {
        NavigationView{
            ScrollView{
                Spacer().frame(height: 12)
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(data, id: \.id) { item in
                        NavigationLink(
                            destination: RestSelectionView(item: item),
                            label: {
                                LazyVStack{
                                    Image(item.keyVisual).resizable().scaledToFit().frame(minWidth: 100, maxWidth: 200, minHeight: 150, maxHeight: 200).cornerRadius(10)
                                    Text(item.title).foregroundColor(.label).padding(8)
                                }
                                .padding()
                                .background(Color.tertiarySystemBackground)
                                .cornerRadius(10)
                            })
                    
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Pflanzenform")
            .background(Color.secondarySystemBackground.ignoresSafeArea(.all))
            .navigationBarItems(leading: Button(action: {
                activeSheet = nil
            }, label: {
                Text("Schließen")
                   
            }))
          
        }.accentColor(.green)
    }
    
}

struct SelectionDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionDashboardView(activeSheet: .constant(.settings))
    }
}
