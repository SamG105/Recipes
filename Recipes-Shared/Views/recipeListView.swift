//
//  recipeListView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct recipeListView: View {
    @Binding var recipes: [recipe]
    
    var body: some View {
        List($recipes) { $recipe in
            NavigationLink(destination: RecipeView(recipe: $recipe)) {
                recipePreview(recipe: recipe)
                
            }
            .padding(.vertical, 5)
            .listRowBackground(recipe.theme.mainColor)
        }
        .navigationTitle(Text("Recipes"))
    }
}


struct recipeListView_Previews: PreviewProvider {
    static var previews: some View {
        recipeListView(recipes: .constant(recipe.sampleData))
    }
}
