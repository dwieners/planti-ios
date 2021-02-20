//
//  LoginView.swift
//  Planti
//
//  Created by Dominik Wieners on 05.12.20.
//

import SwiftUI


enum AuthViewAlerts: Identifiable {
    var id: Int {
        self.hashValue
    }
    case guest
}

struct AuthView: View {
    
    @State var activeSheet: Sheet?
    @State var authViewAlert: AuthViewAlerts?
    
    var body: some View {
        
        VStack{
            Text("Finde heraus, was in deiner Gegend wächst und gedeiht.").font(.largeTitle).bold()
            Spacer()
            Button(
                action: {
                    self.activeSheet = .register
                }, label: {
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
                    self.activeSheet = .login
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
                        authViewAlert = .guest
                    }, label: {
                        Text("Als Gast fortfahren")
                            .foregroundColor(.green)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    })
                    
                }
                Spacer().frame(height: 16)
            }
        }.padding()
        .alert(item: $authViewAlert, content: { item -> Alert in
            switch(item){
            case .guest:
                return Alert(title: Text("Diese Funktion gibt es noch nicht."),
                             dismissButton: .default(Text("OK")))
            }
        })
        .sheet(item: $activeSheet){ item in
            if item == .register {
                RegisterFigureView(activeSheet: $activeSheet)
                    .environmentObject(RegistrationViewModel())
            }
            
            if item == .login {
                LoginView(activeSheet: $activeSheet)
                    .environmentObject(LoginViewModel())
            }
        }
        
        
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().previewAsScreen()
    }
}
