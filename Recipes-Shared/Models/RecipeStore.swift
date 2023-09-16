//
//  RecipeStore.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-26.
//

import SwiftUI
#if os(watchOS)

#endif

@MainActor
class recipeStore: ObservableObject {
    @Published var recipes: [Recipe] = Recipe.sampleData
    @Published var errorWrapper: ErrorWrapper?
    public func addNewLocalRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        Task {
            do {
                try await recipeStore().save(recipes: recipes)
            } catch {
                errorWrapper = ErrorWrapper(error: error,
                                            guidance: "Try again later.")
            }
        }
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("Recipes.Data")
    }
    
    func load() async throws {
        let task = Task<[Recipe], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let recipeList = try JSONDecoder().decode([Recipe].self, from: data)
            return recipeList
        }
        let recipes = try await task.value
        self.recipes = recipes
        
        for var recipe in self.recipes {
            recipe.image = UIImage(data: recipe.imageData ?? Data())
        }
    }
    
    func save(recipes: [Recipe]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(recipes)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
