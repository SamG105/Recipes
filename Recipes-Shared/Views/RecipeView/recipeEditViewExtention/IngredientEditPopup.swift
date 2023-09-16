//
//  IngredientEditPopup.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-07-07.
//

import SwiftUI

struct IngredientEditPopup: View {
    @Binding var ingredient: Recipe.ingredient
    var delete: () -> Void
    //@Binding var isEditing: Bool
    
    @State private var massSelectedUnit: UnitMass = .grams
    @State private var volumeSelectedUnit: UnitVolume = .cups
    
    var body: some View {
        VStack {
            HStack {
                Text("Title")
                TextField("Title", text: $ingredient.name.animation(), axis: .vertical)
            }
            HStack {
                Text("Amount")
                TextField("Number of \(ingredient.name)", value: $ingredient.countableMeasurement.value, format: .number, prompt: Text("Input the amount of ingredient"))
            }
            HStack {
                Text("Mass")
                TextField("Mass of \(ingredient.name)", value: $ingredient.massMeasurement.value, format: .number, prompt: Text("Input the mass of ingredient"))
                    
                Picker("", selection: $massSelectedUnit) {
                    ForEach(UnitMass.allCases, id: \.self) {unit in
                        Text(unit.symbol)
                            .tag(unit)
                    }
                }
                .pickerStyle(.menu)
                //.frame(width: 30, height: 20)
                .padding(.horizontal, -10)
                
            }
            HStack {
                Text("Volume")
                TextField("Volume of \(ingredient.name)", value: $ingredient.volumeMeasurement.value, format: .number, prompt: Text("Input the Volume of ingredient"))
                    
                Picker("", selection: $volumeSelectedUnit) {
                    ForEach(UnitVolume.allCases, id: \.self) {unit in
                        Text(unit.symbol)
                            .tag(unit)
                    }
                }
                .pickerStyle(.menu)
                //.frame(width: 30, height: 20)
                .padding(.horizontal, -10)
                
            }
            
            HStack {
                Button {
                    delete()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete")
                            .font(.system(size: 15, weight: .regular, design: .default))
                        Spacer()
                    }
                }
                
                Button {
                    save()
                    ingredient.isEditing.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(.system(size: 15, weight: .regular, design: .default))
                        Spacer()
                    }
                }
                
            }
            .frame(minWidth: 200, minHeight: 50)
            .buttonStyle(.bordered)
        }
        .multilineTextAlignment(.trailing)
        .padding(.horizontal)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        //.padding(50)
        .onAppear {
            massSelectedUnit = ingredient.massMeasurement.unit
            volumeSelectedUnit = ingredient.volumeMeasurement.unit
        }
    }
    
    private func save() {
        let valueMass = ingredient.massMeasurement.value
        let valueVolume = ingredient.volumeMeasurement.value
        
        let newMass = Measurement(value: valueMass, unit: massSelectedUnit)
        let newVolume = Measurement(value: valueVolume, unit: volumeSelectedUnit)
        
        ingredient.massMeasurement = newMass
        ingredient.volumeMeasurement = newVolume
    }
}

#Preview {
    Form {
        IngredientEditPopup(ingredient: .constant(Recipe.ingredient.empty), delete: {})
        //.padding(50)
        //.background(Material.thick)
    }
}
