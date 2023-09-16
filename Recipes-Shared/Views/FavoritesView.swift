//
//  FavoritesView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-03.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var recipes: [Recipe]
    
    var body: some View {
        NavigationStack {
            List($recipes) { $recipe in
                if recipe.isFavorite == true {
                    NavigationLink(destination: RecipeView(recipe: $recipe)) {
                        recipePreview(recipe: $recipe)
                        
                    }
                    .contextMenu {
                        Button("Delete") {
                            recipes.removeAll(where: {$0.id == recipe.id && $0.name == recipe.name})
                        }
                    }
                    .padding(.vertical, 5)
                    .listRowBackground(recipe.theme.mainColor)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(recipes: .constant(Recipe.sampleData))
    }
}
