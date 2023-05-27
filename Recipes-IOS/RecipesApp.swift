//
//  RecipesApp.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject var store = recipeStore()
    var body: some Scene {
        WindowGroup {
            recipeListView(recipes: $store.recipes)
        }
    }
}
