//
//  PublicStoreView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-07.
//

import SwiftUI

struct PublicStoreView: View {
    @StateObject var store = PublicRecipesStore()
    @State var txt: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink{
                    RecipeView(recipe: $store.recommendedRecipe)
                } label: {
                    RecipeBanner(recipe: store.recommendedRecipe)
                    //.frame(height: 200)
                        .overlay {
                            VStack(alignment: .center) {
                                Spacer()
                                Text(store.recommendedRecipe.name)
                                    .font(.headline)
                                    .padding(.leading, 15)
                                    .padding(.bottom, 30)
                            }
                        }
                }
                
                
                TextField("Search Field", text: $store.searchFieldText, prompt: Text("Search"))
                
                //List {
                ForEach($store.recipes) {$recipe in
                    NavigationLink{
                        RecipeView(recipe: $recipe)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        recipeStore().addNewLocalRecipe(recipe)
                                    } label: {
                                        Label("Add to my list", systemImage: "plus")
                                    }
                                }
                            }
                    }label: {
                        recipePreview(recipe: $recipe)
                    }
                    .listRowBackground(recipe.theme.mainColor)
                }
                .task {
                    do {
                        try await store.getRecipeList()
                    } catch {
                        store.errorWrapper = ErrorWrapper(error: error, guidance: "Not able to load data, retry later. ERROR: ")
                    }
                }
#if DEBUG
                Text(txt)
                    .task {
                        do {
                            self.txt = try await store.greet()
                        } catch {
                            self.txt = String(describing: error)
                        }
                    }
#endif
            }
            .navigationTitle(Text("Recipe Library"))
        }
    }
}

struct PublicStoreView_Previews: PreviewProvider {
    static var previews: some View {
        PublicStoreView()
    }
}
