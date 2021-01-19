//
//  SelectionDashBoardView.swift
//  Planti
//
//  Created by Dominik Wieners on 07.12.20.
//

import SwiftUI

enum PlantShapeType: String, CaseIterable {
    case wildflower = "wildflower";
    case tree = "tree";
    case grasses = "grasses";
    case fern = "fern"
}

struct PlantShape: Identifiable {
    var id = UUID()
    var title: String
    var type: PlantShapeType
    var keyVisual: String
}

struct SelectionDashboardView: View {
    
   
    @State var isShapeSelected: Bool = false

    @Binding var predictionSheet:Sheet?
    @EnvironmentObject var selectionViewModel:SelectionViewModel
    
    
    let data = [
        PlantShape(title: "Wildblume", type: .wildflower, keyVisual: "flower"),
        PlantShape(title: "Baum", type: .tree , keyVisual: "bark"),
        PlantShape(title: "Gräser", type: .grasses , keyVisual: "leaf"),
        PlantShape(title: "Farn", type: .fern ,keyVisual: "fruit"),
    
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
                            destination: SelectionView(predictionSheet: $predictionSheet),
                            isActive: $isShapeSelected,
                            label: {
                                Button(action: {
                                    selectionViewModel.plantShape = item
                                    isShapeSelected.toggle()
                                }, label: {
                                    LazyVStack{
                                        Image(item.keyVisual).resizable().scaledToFit().frame(minWidth: 100, maxWidth: 200, minHeight: 150, maxHeight: 200).cornerRadius(10)
                                        Text(item.title).foregroundColor(.label).padding(8)
                                    }
                                    .padding()
                                    .background(Color.tertiarySystemBackground)
                                    .cornerRadius(10)
                                })
                            })
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Pflanzenform")
            .background(Color.secondarySystemBackground.ignoresSafeArea(.all))
            .navigationBarItems(leading: Button(action: {
                predictionSheet = nil
            }, label: {
                Text("Schließen")
                   
            }))
          
        }
        .accentColor(.green)

    }
    
}

struct SelectionDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionDashboardView(predictionSheet: .constant(nil))
            .environmentObject(SelectionViewModel())
    }
}