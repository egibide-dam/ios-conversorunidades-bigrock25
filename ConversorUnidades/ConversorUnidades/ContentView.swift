//
//  ContentView.swift
//  ConversorUnidades
//
//  Created by Ion Jaureguialzo Sarasola on 18/12/20.
//

import SwiftUI

enum medida: String, CaseIterable{
    case centimetros
    case metros
    case kilometros

}

struct ContentView: View {
    
    @State private var medidaSeleccionada = medida.metros
    @State private var cantidad = 50.0
    
    var body: some View {
        VStack{
            Divider()
            
            Picker("Medida", selection:$medidaSeleccionada){
                ForEach(medida.allCases,id:\.self){med in
                    Text(med.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        Slider(
            value: $cantidad,
            in: 0...100,
            step: 0.25,
            onEditingChanged: { editing in
                isEditing = editing
            },
            minimumValueLabel: Text("0"),
            maximumValueLabel: Text("100")
        )    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
