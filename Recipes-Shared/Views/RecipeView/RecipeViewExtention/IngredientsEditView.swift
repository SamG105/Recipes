//
//  IngredientsEditView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-31.
//

import SwiftUI

struct IngredientsEditView: View {
    @Binding var ingredients: [Recipe.ingredient]
    @Binding var isSaving: Bool
    var body: some View {
        
        ForEach($ingredients) {$ingredients in
            IngredientEditView(ingredient: $ingredients, isSaving: $isSaving)
        }
        
    }
}

struct IngredientsEditView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsEditView(ingredients: .constant(Recipe.sampleData[0].ingredients), isSaving: .constant(false))
    }
}
