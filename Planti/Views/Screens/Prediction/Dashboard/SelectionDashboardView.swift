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
    
    
    @EnvironmentObject var selectionViewModel:SelectionViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @Binding var predictionSheet:Sheet?
    
    @State var isShapeSelected: Bool = false
    
    let data = [
        PlantShape(title: "Wildblume", type: .wildflower, keyVisual: "daisy"),
        PlantShape(title: "Baum", type: .tree , keyVisual: "tree"),
        PlantShape(title: "Gräser", type: .grasses , keyVisual: "grass"),
        PlantShape(title: "Farn", type: .fern ,keyVisual: "fern"),
        
    ]
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16),
        GridItem(.flexible(minimum: 100, maximum: 200)),
    ]
    
    // Actions
    
    func getLocationsFromService() {
        self.locationManager.startUpdating()
        self.selectionViewModel.location = self.locationManager.lastKnownLocation
    }
    
    
    func locationAuthorized() -> Bool{
        return locationManager.authorizationStatus != .notDetermined
    }
    
    
    
    // Views
    var infoLocationView: some View {
        VStack{
            Text("Deine aktuelle Position wird zur bessern Bestimmung verwendet.")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.green)
        .foregroundColor(Color.white)
        .cornerRadius(10.0)
    }
    
    
    var infoNoLocationView: some View {
        VStack{
            Text("Deine App kann nicht auf deine Position zugreifen. Bitte aktuallisiere dies in deinen Einstellungen.")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray)
        .foregroundColor(Color.white)
        .cornerRadius(10.0)
    }
    
    var dashboardGridView: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(data, id: \.id) { item in
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
            }
        }
    }
    
    
    var cancleButton: some View {
        CancelButton {
            locationManager.stopUpdating()
            predictionSheet = nil
        }
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                ScrollView{
                    Spacer().frame(height: 16)
                    if locationAuthorized() {
                        infoLocationView
                    }else {
                        infoNoLocationView
                    }
                    Spacer().frame(height: 16)
                    dashboardGridView
                }
                NavigationLink(destination: SelectionView(predictionSheet: $predictionSheet), isActive: $isShapeSelected) {
                    Spacer().fixedSize()
                }
            }.padding(.horizontal)
            .background(Color.quaternarySystemFill.ignoresSafeArea(.all))
            .navigationBarTitle("Pflanzenform", displayMode: .automatic)
            .navigationBarItems(leading: cancleButton)
            .onAppear(perform: getLocationsFromService)
        }.accentColor(.green)
        
    }
    
    
    
    
}

struct SelectionDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionDashboardView(predictionSheet: .constant(nil))
            .environmentObject(SelectionViewModel())
            .environmentObject(LocationManager())
    }
}
