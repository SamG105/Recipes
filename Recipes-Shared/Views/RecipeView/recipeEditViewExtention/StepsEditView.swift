//
//  StepsEditView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-04.
//

import SwiftUI

struct StepsEditView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        Section("Steps") {
            HStack {
                Spacer()
                Button(action: {recipe.steps.append(Recipe.step(text: ""))}) {
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
}

struct StepsEditView_Previews: PreviewProvider {
    static var previews: some View {
        StepsEditView(recipe: .constant(Recipe.emptyRecipe))
    }
}
