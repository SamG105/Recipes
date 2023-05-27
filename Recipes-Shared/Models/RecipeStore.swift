//
//  RecipeStore.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-26.
//

import Foundation

class recipeStore: ObservableObject {
    @Published var recipes: [recipe] = recipe.sampleData
}
