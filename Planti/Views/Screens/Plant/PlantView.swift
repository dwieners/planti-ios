//
//  PlantDetailView.swift
//  Planti
//
//  Created by Dominik Wieners on 08.01.21.
//

import SwiftUI

struct PlantView: View {
    
       var body: some View{
           
           ZStack(alignment: .top, content: {
               
               ScrollView(.vertical, showsIndicators: false, content: {
                   
                   VStack{
                       
                       // now going to do strechy header....
                       // follow me...
                       
                       GeometryReader{g in
                        ZStack{
                               Image("flower")
                               .resizable()
                               // fixing the view to the top will give strechy effect...
                              //  increasing height by drag amount....
                               .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                               .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2)
                              
                            VStack {
                                Spacer()
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Gänseblümchen")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            
                    
                                        Text("Bellis perennis")
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
                                Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet").font(.body)
                            }.padding(8)
                            Divider()
                            VStack(alignment: .leading){
                                Text("Beschreibung").font(.headline).padding(.bottom, 4)
                                Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet").font(.body)
                            }.padding(8)
                                  
                               
                        }.padding()
                    
                   
                       
                       Spacer()
                   }
               })
               
           
           })
           .edgesIgnoringSafeArea(.top)
           .navigationBarTitle(Text("Gänseblümchen"), displayMode: .inline)
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
        
        PlantView().previewAsScreen()
    }
}
