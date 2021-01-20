//
//  PlantDetailView.swift
//  Planti
//
//  Created by Dominik Wieners on 08.01.21.
//

import SwiftUI

struct PlantiIndicatorView: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                       maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                       maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.frame(
            minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
            maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
            minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
            idealHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading)
        .edgesIgnoringSafeArea(.all)
    }
}



struct PlantView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var plantViewModel: PlantViewModel
    
    @State private var isLoading:Bool = false
    @State private var opacity:Double = 0
    
    var key:String
    var predictionSheet: Binding<Sheet?>?
    
    
    private func addItem() {
        guard let plant = plantViewModel.plant, let plantImage = plantViewModel.uiImage else {
            return
        }
        
        let newItem = PlantRecord(context: viewContext)
        newItem.timestamp = Date()
        newItem.key = key
        newItem.title = plant.title
        newItem.scientific_name = plant.scientific_name
        newItem.image = plantImage.jpegData(compressionQuality: 1.0)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    
    
    var body: some View{
        VStack{
            ZStack {
                if plantViewModel.isLoading {
                    PlantiIndicatorView()
                        .zIndex(2)
                } else {
                    if let plant = plantViewModel.plant {
                        PlantViewContent(plant: plant)
                            .opacity(opacity)
                            .onAppear(perform: {
                                withAnimation(.default) {
                                    self.opacity = 1
                                }
                            })
                            .zIndex(1)
                    }
                    if let preSheet = predictionSheet {
                        VStack {
                            Spacer()
                            FloatingButton(action: {
                                addItem()
                                preSheet.wrappedValue = nil
                            },
                            image: Image(systemName: "checkmark.circle.fill"),
                            label: "Bestätigen"
                            )
                            
                        }
                        .padding()
                        .zIndex(3)
                    }
                    
                }
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle(Text("Details"), displayMode: .inline)
        
        .onAppear(perform: {
            plantViewModel.loadInfo(key: key)
        })
        
    }
    
}


struct PlantViewContent : View {
    
    @EnvironmentObject private var plantViewModel: PlantViewModel
    
    @State private  var image: UIImage = UIImage()
    @State private var opacity:Double = 0.0
    
    private var currentPlant: PlantInfo
    
    @ObservedObject private var imageLoader: ImageLoader
    
    init(plant: PlantInfo) {
        self.currentPlant = plant
        self.imageLoader = ImageLoader(urlString: plant.image)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        GeometryReader{g in
                            ZStack{
                                Image(uiImage: image)
                                    .resizable()
                                    // fixing the view to the top will give strechy effect...
                                    //  increasing height by drag amount....
                                    .offset(
                                        y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0
                                    )
                                    .onReceive(imageLoader.didChange){ data in
                                        
                                        self.image = UIImage(data: data) ?? UIImage()
                                        self.plantViewModel.uiImage = self.image
                                    }
                                    .frame(
                                        height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2,
                                        alignment: .center
                                    )
                                VStack {
                                    Spacer()
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text(currentPlant.title)
                                                .font(.title)
                                                .fontWeight(.bold)
                                            Text(currentPlant.description)
                                                .font(.headline)
                                        }
                                        Spacer()
                                        
                                    }.padding()
                                    .background(BlurView(style: .prominent))
                                }    .offset(
                                    y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0
                                )
                                .frame(
                                    height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2,
                                    alignment: .center
                                    
                                )
                                
                            }
                            
                        }
                        // fixing default height...
                        .frame(height: UIScreen.main.bounds.height / 2.2)
                        LazyVStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Text("Taxonomie").font(.headline).padding(.bottom, 4)
                                Text(currentPlant.taxonomy).font(.body)
                            }.padding(8)
                            Divider()
                            VStack(alignment: .leading){
                                Text("Beschreibung").font(.headline).padding(.bottom, 4)
                                Text(currentPlant.description).font(.body)
                            }.padding(8)
                            
                        }.padding()
                        
                    }
                }
            }
            .opacity(opacity)
            .onAppear(perform: {
                withAnimation(.default) {
                    self.opacity = 1
                }
            })
            
        }
        
        .ignoresSafeArea(.keyboard, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        
        
    }
    
}

struct BlurView : UIViewRepresentable {
    
    var style : UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}



struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            PlantView(key: "bellis_perennis", predictionSheet: .constant(.selection))
                .environmentObject(PlantViewModel())
        }
        .accentColor(.green)
    }
}
