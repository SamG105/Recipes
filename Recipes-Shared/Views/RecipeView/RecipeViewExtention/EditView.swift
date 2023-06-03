//
//  EditView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-29.
//

import SwiftUI

struct EditView: View {
    @Binding var recipe: Recipe
    @Binding var isSaving: Bool
    
    var body: some View {
        Form {
            Section("Image") {
                HStack {
                    Spacer()
                    //DropZoneView(image: $recipe.image, fillColor: recipe.theme.mainColor)
                    DropZoneView(image: $recipe.image, fillColor: recipe.theme.mainColor )
                    Spacer()
                }
            }
            EditViewGeneral(recipe: $recipe)
            Section("Ingredients") {
                HStack {
                    Spacer()
                    Button(action: {recipe.ingredients.append(Recipe.ingredient.empty)}) {
                        Image(systemName: "plus.circle")
                    }
                  Spacer()
                }
                
                IngredientsEditView(ingredients: $recipe.ingredients, isSaving: $isSaving)
                    //.frame(width: 100, height: 50000)
            }
            
            
            Section("Steps") {
                HStack {
                    Spacer()
                    Button(action: {recipe.steps.append(Recipe.step.empty)}) {
                        Image(systemName: "plus.circle")
                    }
                  Spacer()
                }
                ForEach($recipe.steps) {$step in
                    HStack {
                        //TextEditor(text: $step.text)
                        TextField("", text: $step.text, axis: .vertical)
                    }
                }
            }
        }
        //.foregroundColor(recipe.theme.accentColor)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(recipe: .constant(Recipe.sampleData[0]), isSaving: .constant(false))
    }
}
