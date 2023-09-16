//
//  ContentView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    @State private var editingRecipe = Recipe.emptyRecipe
    @State private var isPresentingEditView = false
    
    var body: some View {
        NavigationStack {
            GeometryReader {geo in
                ScrollView {
                    VStack {
                        RecipeHeaderView(recipe: $recipe, geo: geo)
                        
                        Spacer()
                        Text(recipe.description)
                        Spacer()
                        
                        IngredientsView(recipe: $recipe)
                            //.frame(width: geo.size.width - 30)
                            .padding()
                        
                        Rectangle()
                            .frame(height: 2)
                            .cornerRadius(1)
                            .foregroundColor(recipe.theme.mainColor)
                        
                        StepsView(recipe: $recipe)
                            .padding()
                        
                        TextField("Notes", text: $recipe.notes, prompt: Text("Add Your personal notes"))
                            .padding()
                        
                        if let link = recipe.link {
                            Link(destination: link) {
                                Text("Go to Website")
                            }
                        }
                    }
                }
                //.ignoresSafeArea()
            }
            .offset(y: -30)
            .toolbar {
                /*ToolbarItem(placement: .bottomBar) {
                    Button("Delete") {
                        recipeStore().recipes.removeAll(where: {$0.id == recipe.id && $0.name == recipe.name})
                    }
                    .buttonStyle(.bordered)
                }*/
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        isPresentingEditView = true
                        editingRecipe = recipe
                    }
                    .buttonStyle(.bordered)
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationStack {
                    //EditView(recipe: $editingRecipe, isSaving: $isPresentingEditView)
                    RecipeEditView(recipe: $editingRecipe)
                        //.navigationTitle(recipe.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    recipe = editingRecipe
                                }
                            }
                        }
                }
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .constant(Recipe.sampleData[0]))
    }
}
