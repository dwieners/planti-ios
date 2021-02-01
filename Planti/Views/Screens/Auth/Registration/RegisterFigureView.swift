//
//  RegisterFigureView.swift
//  Planti
//
//  Created by Dominik Wieners on 25.01.21.
//

import SwiftUI

struct FigureOption {
    var title: String
    var type: FigureType
}

struct RegisterFigureView: View {
    
    @EnvironmentObject var registrationViewModel: RegistrationViewModel
    
    @Binding var activeSheet: Sheet?
    
    
    @State var figureOptions = [
        FigureOption(title: "Hexe", type: .WITCH),
        FigureOption(title: "Zauberer", type: .WIZARD)
    ]
    
    @State private var selectedOptionIndex = 0
    
    var body: some View {
        NavigationView {
            VStack{
                InfoCard(
                    image: Image("magic-wand"), text: "Möchtest du lieber eine Hexe oder ein Zauberer sein?"
                )
                Picker(selection: $selectedOptionIndex, label: Text("Strength")) {
                    ForEach(0 ..< figureOptions.count) {
                        Text(self.figureOptions[$0].title)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Spacer()
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color.secondarySystemBackground)
            .navigationBarTitle("Deine Figur", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        activeSheet = nil
                    }, label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .frame(width: 44, height: 44, alignment: .leading)
                    }),
                trailing:
                    NavigationLink(
                        destination:
                            RegistrationView(
                                activeSheet: $activeSheet,
                                figureType: $figureOptions[selectedOptionIndex]
                            )
                    ) {
                        Text("Weiter")
                        
                    }
            )
        }.accentColor(.green)
        
    }
}

struct RegisterFigureView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFigureView(activeSheet: .constant(.register))
            .foregroundColor(.green)
            .environmentObject(RegistrationViewModel())
    }
}
