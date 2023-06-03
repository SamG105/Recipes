//
//  IngredientsView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-25.
//

import SwiftUI

struct IngredientsView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        VStack {
            Section("Ingredients") {
                ForEach($recipe.ingredients) {ingredient in
                    IngredientView(ingredient: ingredient, theme: recipe.theme)
                }
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            IngredientsView(recipe: .constant(Recipe.sampleData[0]))
        }
    }
}
