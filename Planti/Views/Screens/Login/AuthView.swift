//
//  LoginView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI

struct AuthView: View {
    
    //@EnvironmentObject var auth: AuthViewModel
    
    @State var showingDetail = false
    
    var body: some View {
        
        VStack{
            Text("Finde heraus, was in deiner Gegend wächst und gedeiht.").font(.largeTitle).bold()
            Spacer()
            Button(action: {self.showingDetail.toggle()}, label: {
                LazyVStack {
                 Text("Account erstellen")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical,10)
                    .padding(.horizontal,25)
                    .foregroundColor(.white)
                }
                .frame(height: 50)
                .background(Color.green)
                .mask(Capsule())
                .padding(.horizontal)
            })
            Spacer().frame(height: 32)
            LazyVStack{
                Button(action: {
                    
                }) {
                    LazyVStack {
                        Text("Anmelden")
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                        
                    }  // for adapting to dark mode...
                    .frame(height: 50)
                    .background(Color.primary.opacity(0.06))
                    .mask(Capsule())
                    .padding(.horizontal)
   
                }

                
                Spacer().frame(height: 40)
                HStack(spacing: 6){
                    Button(action: {
                        print("Hallo")
                    }, label: {
                        Text("Als Gast fortfahren")
                            .foregroundColor(.green)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                    })
                    
                }
                Spacer().frame(height: 16)
            }
        }.padding()
        .sheet(isPresented: $showingDetail) {
            RegisterView(showModal: self.$showingDetail)
        }
        
        
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().previewAsScreen()
    }
}
