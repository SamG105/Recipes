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
    @StateObject private var publicStore = PublicRecipesStore()
    @State private var errorWrapper: ErrorWrapper?
    @Environment(\.dismiss) private var dismiss
    
    var body: some Scene {
        WindowGroup {
            MainContent(recipes: $store.recipes) {
                //saves on state change
                Task {
                    do {
                        try await store.save(recipes: store.recipes)
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
                //load publicStore
                
                do {
                    try await publicStore.getRecipeList()
                } catch {
                    publicStore.errorWrapper = ErrorWrapper(error: error, guidance: "Not able to load data, retry later. ERROR: ")
                }
                
            }
            .alert(item: $errorWrapper) { alert in
                Alert(title: Text("An error has occurred!"), message: Text("\(alert.guidance) \n \(alert.error.localizedDescription) "), dismissButton: .cancel(Text("Dismiss"), action: {dismiss()}))
            }
        }
    }
}
