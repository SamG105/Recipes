//
//  GroceriesView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct GroceryView: View {
    @Binding var recipes: [Recipe]
    
    var body: some View {
        NavigationStack {
            List($recipes) { $ListRecipe in
                if ListRecipe.ingredients.filter({$0.isOnList == true}).count != 0 {
                    Section(ListRecipe.name) {
                        ForEach($ListRecipe.ingredients.filter({$0.isOnList.wrappedValue == true})) {$ingredient in
                            NavigationLink(destination: RecipeView(recipe: $ListRecipe)) {
                                HStack {
                                    Text(ingredient.name)
                                    Spacer()
                                    if ingredient.countableMeasurement.value != 0 {
                                        Text("\(ingredient.countableMeasurement.value)")
                                    }
                                    
                                    if ingredient.massMeasurement.value != 0{
                                        Text("\(ingredient.massMeasurement.value.formatted()) \(ingredient.massMeasurement.unit.symbol)")
                                    }
                                    if ingredient.volumeMeasurement.value != 0 {
                                        Text("\(ingredient.volumeMeasurement.value.formatted()) \(ingredient.volumeMeasurement.unit.symbol)")
                                    }
                                }
                                .accessibilityElement(children: .combine)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    withAnimation(.linear(duration: 100)) {
                                        ingredient.isOnList.toggle()
                                    }
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle(Text("Grocery List"))
        }
    }
}

struct GrocerysView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryView(recipes: .constant(Recipe.sampleData))
        }
    }
}
