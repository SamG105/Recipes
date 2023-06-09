//
//  IngredientView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-25.
//

import SwiftUI

struct IngredientView: View {
    @Binding var ingredient: Recipe.ingredient
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
                if quantity.value != 0 {
                    Text("\(quantity.value)")
                }
            }
            if let mass = ingredient.massMeasurement {
                if mass.value != 0{
                    Text("\(mass.value.formatted()) \(mass.unit.symbol)")
                }
            }
            if let volume = ingredient.volumeMeasurement {
                if volume.value != 0 {
                    Text("\(volume.value.formatted()) \(volume.unit.symbol)")
                }
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
        IngredientView(ingredient: .constant(Recipe.sampleData[0].ingredients[0]), theme: .orange)
    }
}
