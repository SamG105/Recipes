//
//  RecipesApp.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject private var store = recipeStore()
    @State private var errorWrapper: ErrorWrapper?
    @Environment(\.dismiss) private var dismiss
    
    var body: some Scene {
        WindowGroup {
            MainTabView(recipes: $store.recipes) {
                //saves on state change
                Task {
                    do {
                        try await store.save(scrums: store.recipes)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
            .task {
                //loads data
                do {
                    try await store.load()
                    if store.recipes.isEmpty {
                        //loads samples if first time opening app
                        store.recipes = Recipe.sampleData
                    }
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Recipes will load samples and continue.")
                }
            }
            .alert(item: $errorWrapper) { alert in
                Alert(title: Text("An error has occurred!"), message: Text("\(alert.guidance) \n \(alert.error.localizedDescription) "), dismissButton: .cancel(Text("Dismiss"), action: {dismiss()}))
            }
        }
    }
}
