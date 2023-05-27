//
//  IngredientView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-25.
//

import SwiftUI

struct IngredientView: View {
    @Binding var ingredient: recipe.ingredient
    var theme: Theme
    
    var body: some View {
        HStack {
            Button {
                ingredient.isOnList.toggle()
            } label: {
                Image(systemName: ingredient.isOnList ?  "list.clipboard.fill" : "list.clipboard")
                    .foregroundColor(ingredient.isOnList ? theme.accentColor : theme.accentColor)
            }
            
            if let quantity = ingredient.countableMeasurement {
                Text("\(quantity.unit) \(quantity.value)")
            }
            if let mass = ingredient.massMeasurement {
                Text("\(Int(mass.value)) \(mass.unit.symbol)")
            }
            if let volume = ingredient.volumeMeasurement {
                Text("\(Int(volume.value)) \(volume.unit.symbol)")
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                Text(ingredient.name)
                    //.minimumScaleFactor(0.9)
                    .padding(.leading, 15)
            }
            //.frame(width: 50)
           // Spacer()
        }
        .frame(height: 15)
        .padding()
        .background(theme.mainColor)
        .foregroundColor(theme.accentColor)
        .cornerRadius(5)
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(ingredient: .constant(recipe.sampleData[0].ingredients[0]), theme: .orange)
    }
}
