//
//  IngredientEditView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-30.
//

import SwiftUI

struct IngredientEditView: View {
    @Binding var ingredient: Recipe.ingredient
    @State private var massSelectedUnit: UnitMass = .kilograms
    @State private var volumeSelectedUnit: UnitVolume = .cups
    @Binding var isSaving: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("Name", text: $ingredient.name)
                    
                Spacer()
                //other
                TextField("Enter value", value: $ingredient.countableMeasurement.value, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                    //.padding(.horizontal)
                
                TextField("Unit", text: $ingredient.countableMeasurement.unit)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: 60)
            }
            HStack {
                //mass
                TextField("Enter value", value: $ingredient.massMeasurement.value, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //.padding(.horizontal, -50)
                
                Picker("", selection: $massSelectedUnit) {
                    ForEach(UnitMass.allCases, id: \.self) { unit in
                        Text(unit.symbol)
                    }
                }
                .pickerStyle(.menu)
                //.padding(.horizontal, 5)
                //volume
                TextField("Enter value", value: $ingredient.volumeMeasurement.value, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //.padding(.horizontal)
                
                Picker("", selection: $volumeSelectedUnit) {
                    ForEach(UnitVolume.allCases, id: \.self) { unit in
                        Text(unit.symbol)
                    }
                }
                .pickerStyle(.menu)
                //.padding(.horizontal)
            }
        }
        .multilineTextAlignment(.center)
        .onChange(of: isSaving) { isSaving in
            if isSaving {
                save()
            }
        }
    }
    
    func save() {
        ingredient.volumeMeasurement = ingredient.volumeMeasurement.converted(to: volumeSelectedUnit)
        ingredient.massMeasurement = ingredient.massMeasurement.converted(to: massSelectedUnit)
    }
}

struct IngredientEditView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientEditView(ingredient: .constant(Recipe.sampleData[0].ingredients[0]), isSaving: .constant(false))
    }
}
