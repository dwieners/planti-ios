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
    
    
    var key:String
    var predictionSheet: Binding<Sheet?>?
    
    @ObservedObject private var plantViewModel = PlantViewModel()
    @State private var isLoading:Bool = false
    @State private var opacity:Double = 0
    @State private var showUploadAlert:Bool = false
    
    
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
                                preSheet.wrappedValue = nil
                            },
                            image: Image(systemName: "checkmark.circle.fill"),
                            label: "Bestätigen"
                            )
                            
                        }
                        .padding()
                        .navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Button(action: {
                                showUploadAlert.toggle()
                            }, label: {
                                Image(systemName: "tray.and.arrow.up").resizable().scaledToFit()
                            })
                            .alert(isPresented: $showUploadAlert) {
                                Alert(
                                    title: Text("Bilder hochladen?"),
                                    message: Text("Mit deinen Bildern hilfst du uns Planti zu verbessern"),
                                    primaryButton: .default(Text("Bilder spenden")) {
                                        print("Bilder spenden")
                                    },
                                    secondaryButton: .cancel())
                            }
                        }))
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
    
    var plant: PlantInfo
    
    @State private  var image: UIImage = UIImage()
    @State private var opacity:Double = 0.0
    
    @ObservedObject private var imageLoader: ImageLoader
    
    
    
    init(plant: PlantInfo) {
        self.plant = plant
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
                                    }
                                    .frame(
                                        height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2,
                                        alignment: .center
                                    )
                                
                                
                                
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
                                Text(plant.taxonomy).font(.body)
                            }.padding(8)
                            Divider()
                            VStack(alignment: .leading){
                                Text("Beschreibung").font(.headline).padding(.bottom, 4)
                                Text(plant.description).font(.body)
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
        }
        .accentColor(.green)
    }
}
