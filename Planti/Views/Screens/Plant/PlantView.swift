//
//  PlantDetailView.swift
//  Planti
//
//  Created by Dominik Wieners on 08.01.21.
//

import SwiftUI

struct PlantView: View {
    
    
    var key:String
    
    @ObservedObject private var plantViewModel = PlantViewModel()
    
    var body: some View{
        VStack{
            ZStack {
                if plantViewModel.isLoading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                } else {
                    if let plant = plantViewModel.plant {
                        PlantViewContent(plant: plant)
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
    
    var plant: PlantInfo
    
    @State private  var image: UIImage = UIImage()
    @ObservedObject private var imageLoader: ImageLoader
    
    init(plant: PlantInfo) {
        self.plant = plant
        self.imageLoader = ImageLoader(urlString: plant.image)
    }
    
    var body: some View {
        ZStack(alignment: .top, content: {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    // now going to do strechy header....
                    // follow me...
                    
                    GeometryReader{g in
                        ZStack{
                            Image(uiImage: image)
                                .resizable()
                                // fixing the view to the top will give strechy effect...
                                //  increasing height by drag amount....
                                .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                                .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2)
                                .onReceive(imageLoader.didChange){ data in
                                    self.image = UIImage(data: data) ?? UIImage()
                                }
                                
                            
                            VStack {
                                Spacer()
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(plant.title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        
                                        Text(plant.scientific_name)
                                            .font(.headline)
                                    }
                                    Spacer()
                                    
                                    
                                }.padding()
                                .background(BlurView(style: .prominent))
                            }    .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                            .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2)
                            
                        }
                        
                    }
                    // fixing default height...
                    .frame(height: UIScreen.main.bounds.height / 2.2)
                    
                    
                    
                    LazyVStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("Taxonomie").font(.headline).padding(.bottom, 4)
                            Text(plant.taxonomy).font(.body)
                        }.padding(8)
                        Divider()
                        VStack(alignment: .leading){
                            Text("Beschreibung").font(.headline).padding(.bottom, 4)
                            Text(plant.description).font(.body)
                        }.padding(8)
                        
                        
                    }.padding()
                    
                    
                    
                    Spacer()
                }
            })
            
            
        })
    }
}

// CardView...

struct CardView : View {
    
    var data : Card
    
    var body: some View{
        
        HStack(alignment: .top, spacing: 20){
            
            Image(self.data.image)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(self.data.title)
                    .fontWeight(.bold)
                
                Text(self.data.subTitile)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("GET")
                            .fontWeight(.bold)
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                            // for adapting to dark mode...
                            .background(Color.primary.opacity(0.06))
                            .clipShape(Capsule())
                    }
                    
                    Text("In-App Purchases")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer(minLength: 0)
        }
    }
}


// sample data for cards....

struct Card : Identifiable {
    
    var id : Int
    var image : String
    var title : String
    var subTitile : String
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
        
        PlantView(key: "bellis_perennis").previewAsScreen()
    }
}
