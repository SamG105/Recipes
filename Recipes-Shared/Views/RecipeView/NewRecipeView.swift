//
//  NewRecipeView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-29.
//

import SwiftUI

struct NewRecipeView: View {
    @State private var newRecipe = Recipe.emptyRecipe
    @Binding var recipes: [Recipe]
    @Binding var isPresentingNewRecipeView: Bool
    
    var body: some View {
        NavigationStack {
            //EditView(recipe: $newRecipe, isSaving: $isPresentingNewRecipeView)
            RecipeEditView(recipe: $newRecipe)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewRecipeView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            recipes.append(newRecipe)
                            isPresentingNewRecipeView = false
                        }
                    }
                }
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView(recipes: .constant([]), isPresentingNewRecipeView: .constant(true))
    }
}
