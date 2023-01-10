//
//  ContentView.swift
//  ConversorUnidades
//
//  Created by Ion Jaureguialzo Sarasola on 18/12/20.
//

import SwiftUI

enum Unidades_internacional: String, CaseIterable, Identifiable {
    case centimetros
    case metros
    case kilometros

    var id: String { self.rawValue }
}

enum Unidades_imperial: String, CaseIterable, Identifiable {
    case pulgadas
    case pies
    case millas

    var id: String { self.rawValue }
}

func calcularConversion(from: Unidades_internacional, to: Unidades_imperial, value: Double) -> Double  {

    var unit = Measurement(value: value, unit: UnitLength.meters)
    
    switch from {
    case Unidades_internacional.centimetros:
        unit = Measurement(value: value, unit: UnitLength.centimeters)
    case Unidades_internacional.metros:
        unit = Measurement(value: value, unit: UnitLength.meters)
    case Unidades_internacional.kilometros:
        unit = Measurement(value: value, unit: UnitLength.kilometers)
    }
    
    switch to {
    case Unidades_imperial.pulgadas:
        return unit.converted(to: UnitLength.inches).value
    case Unidades_imperial.pies:
        return unit.converted(to: UnitLength.feet).value
    case Unidades_imperial.millas:
        return unit.converted(to: UnitLength.miles).value
    }
    
}

struct ContentView: View {
    @State private var sliderValue : Double = 50.0
    @State private var isEditing = false
    
    @State private var UniSelec_internacional = Unidades_internacional.metros
    @State private var UniSelec_imperial = Unidades_imperial.pies

    var body: some View {
        VStack {
            
            Spacer()
            
            Picker("Unidades", selection: $UniSelec_internacional) {
                ForEach(Unidades_internacional.allCases, id: \.self) { unidad in
                    Text(unidad.rawValue.capitalized)
                }
            }
                .pickerStyle(SegmentedPickerStyle())

         
            
            Slider(
                value: $sliderValue,
                in: 0...100,
                step: 1,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                minimumValueLabel: Text("0"),
                maximumValueLabel: Text("100")
            ) {
                Text("Speed")
            }.accentColor(.green)
            Text(String(format: "%.2f", sliderValue))
                .foregroundColor(isEditing ? .blue : .green)
            
            Picker("Unidades", selection: $UniSelec_imperial) {
                ForEach(Unidades_imperial.allCases, id: \.self) { unidad in
                    Text(unidad.rawValue.capitalized)
                }
            }
                .pickerStyle(SegmentedPickerStyle())

            
            let conversion = calcularConversion(from: UniSelec_internacional, to: UniSelec_imperial, value: sliderValue);
            
            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 300, height: 300)
                
                VStack {
                    Text("\(String(format: "%.2f", sliderValue))  \(UniSelec_internacional.rawValue) son")
                    Text(String(format: "%.2f", conversion))
                        .font(.system(size: 50))
                    Text("\(UniSelec_imperial.rawValue)")
                }
            }
            .padding()
    
            
            Spacer();
            
        }
            .padding(.horizontal, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
