//
//  RecipeListItemView.swift
//  Recipes-Watch Watch App
//
//  Created by Samuel Guay on 2023-08-03.
//

import SwiftUI

struct RecipeListItemView: View {
    var recipe: Recipe
    
    var body: some View {
        ZStack {
            
            Image(uiImage: recipe.image)
                .frame(height: 75)
        }
        .overlay(alignment: .bottomLeading) {
            Text(recipe.name)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    RecipeListItemView(recipe: Recipe.sampleData[0])
}
