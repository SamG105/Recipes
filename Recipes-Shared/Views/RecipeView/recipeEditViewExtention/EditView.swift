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
                    //DropZoneView(image: $recipe.image, fillColor: recipe.theme.mainColor )
                    Spacer()
                }
            }
            //EditViewGeneral(recipe: $recipe)
            
            //IngredientsEditView(recipe: $recipe, ingredients: $recipe.ingredients, isSaving: $isSaving)
            
            StepsEditView(recipe: $recipe)
            
            
            Section("Notes") {
                TextField("Notes", text: $recipe.notes, axis: .vertical)
                
                //TextField("Link", value: $recipe.link, formatter: .url)
            }
        }
        .formStyle(.columns)
        //.foregroundColor(recipe.theme.accentColor)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(recipe: .constant(Recipe.sampleData[0]), isSaving: .constant(false))
    }
}
