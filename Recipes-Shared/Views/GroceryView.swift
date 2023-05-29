//
//  GroceriesView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct GroceryView: View {
    @Binding var recipes: [recipe]
    var body: some View {
        List($recipes) { $ListRecipe in
            if ListRecipe.ingredients.filter({$0.isOnList == true}).count != 0 {
                Section(ListRecipe.name) {
                    ForEach($ListRecipe.ingredients.filter({$0.isOnList.wrappedValue == true})) {$ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            if let mass = ingredient.massMeasurement {
                                Text("(\(mass.value.formatted()) \(mass.unit.symbol))")
                            }
                            if let volume = ingredient.volumeMeasurement {
                                Text("(\(volume.value.formatted()) \(volume.unit.symbol))")
                            }
                            if let countable = ingredient.countableMeasurement {
                                Text("\(countable.value)")
                            }
                            
                            Button {
                                withAnimation(.linear(duration: 100)) {
                                    ingredient.isOnList.toggle()
                                }
                            } label: {
                                Image(systemName: "x.circle.fill")
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

struct GrocerysView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryView(recipes: .constant(recipe.sampleData))
        }
    }
}
