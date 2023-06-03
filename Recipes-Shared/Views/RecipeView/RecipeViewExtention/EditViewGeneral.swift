//
//  EditViewGeneral.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-29.
//

import SwiftUI

struct EditViewGeneral: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        Section("recipe info") {
            TextField("Title", text: $recipe.name, axis: .vertical)
            
            HStack {
                
                Stepper(value: $recipe.rating,in: 0...1, step: 0.2) {
                    RatingView(rating: recipe.rating)
                }
            }
            VStack {
                Text("Preparation Time")
                HStack {
                    Stepper(value: $recipe.preparationTime.hours, in: 0...100) {
                        Text("\(String(recipe.preparationTime.hours)) h")
                    }
                    Stepper(value: $recipe.preparationTime.minutes, in: 0...59) {
                        Text("\(String(recipe.preparationTime.minutes )) min")
                    }
                }
            }
            VStack {
                Text("Cooking Time")
                HStack {
                    Stepper(value: $recipe.cookingTime.hours, in: 0...100) {
                        Text("\(String(recipe.cookingTime.hours)) h")
                    }
                    Stepper(value: $recipe.cookingTime.minutes, in: 0...59) {
                        Text("\(String(recipe.cookingTime.minutes )) min")
                    }
                }
            }
            VStack {
                Text("Chilling Time")
                HStack {
                    Stepper(value: $recipe.chillingTime.hours, in: 0...100) {
                        Text("\(String(recipe.chillingTime.hours)) h")
                    }
                    Stepper(value: $recipe.chillingTime.minutes, in: 0...59) {
                        Text("\(String(recipe.chillingTime.minutes )) min")
                    }
                }
            }
            
            VStack {
                Text("Portion")
                
                HStack {
                    Stepper(value: $recipe.portion.value) {
                        Text(String(recipe.portion.value))
                    }
                    TextField("Measurement", text: $recipe.portion.unit)
                }
            }
            Picker("Theme", selection: $recipe.theme) {
                ForEach(Theme.allCases) { theme in
                    Text(theme.name)
                        .tag(theme)
                        .padding(.horizontal)
                        .background(theme.mainColor)
                        .foregroundColor(theme.accentColor)
                        .cornerRadius(10)
                }
            }
            .pickerStyle(.wheel)
            
            /*TextEditor(text: $recipe.description)
                .frame(height: max(60, 200))*/
            TextField("Enter the description here", text: $recipe.description, axis: .vertical)
        }
    }
}

/*struct EditViewGeneral_Previews: PreviewProvider {
    static var previews: some View {
        EditViewGeneral(recipe: .constant(recipe.emptyRecipe))
    }
}
*/
