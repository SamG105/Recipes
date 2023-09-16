//
//  PublicStore.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-07.
//

import SwiftUI
import Vapor
#if os(watchOS)

#endif

@MainActor
class PublicRecipesStore: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchFieldText = ""
    @Published var isLoadingData: Bool = false
    @Published var errorWrapper: ErrorWrapper?
    
    var recommendedRecipe: Recipe = Recipe.sampleData[0]
    
    let baseURL = URL(string: "http://127.0.0.1:8080")!
    
    func greet() async throws -> String {
        let url = baseURL.appendingPathComponent("/hello")
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard let responseBody = String(data: data, encoding: .utf8) else {
            throw Errors.invalidResponseEncoding
        }
        return responseBody
    }
    
    
    func getRecipeList() async throws {
        self.isLoadingData = true
        Logger(label: "debug network").trace("begun loading")
        let task = Task<[Recipe], Error> {
            let url = baseURL.appendingPathComponent("/recipe")
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            let recipeList = try JSONDecoder().decode([Recipe].self, from: data)
            return recipeList
        }
        Logger(label: "debug network").trace("finished loading")
        let recipes = try await task.value
        print(recipes)
        self.recipes = recipes
        
        for var recipe in self.recipes {
            recipe.image = UIImage(data: recipe.imageData ?? Data())
        }
        self.isLoadingData = false
        Logger(label: "debug network").trace("finished func")
    }
    
    enum Errors: Error {
        case invalidResponseEncoding
    }
}
