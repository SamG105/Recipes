//
//  recipeListView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct recipeListView: View {
    @Binding var recipes: [Recipe]
    @Binding var isPresentingNewRecipeView: Bool
    
    var body: some View {
        List($recipes) { $recipe in
            NavigationLink(destination: RecipeView(recipe: $recipe)) {
                recipePreview(recipe: recipe)
                
            }
            .contextMenu {
                Button("Delete") {
                    recipes.removeAll(where: {$0.id == recipe.id && $0.name == recipe.name})
                }
            }
            .padding(.vertical, 5)
            .listRowBackground(recipe.theme.mainColor)
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    isPresentingNewRecipeView = true
                } label: {
                    Image(systemName: "plus")
                    
                }
                .accessibilityLabel("New Recipe")
            }
        }
        .navigationTitle(Text("Recipes"))
    }
}


struct recipeListView_Previews: PreviewProvider {
    static var previews: some View {
        recipeListView(recipes: .constant(Recipe.sampleData), isPresentingNewRecipeView: .constant(false))
    }
}
