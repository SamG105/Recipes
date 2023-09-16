//
//  ContentView.swift
//  Recipes-Watch Watch App
//
//  Created by Samuel Guay on 2023-08-03.
//

import SwiftUI

struct ContentView: View {
    @State var selected: Recipe? = nil
    var body: some View {
        NavigationSplitView {
            List(selection: $selected, content: {
                ForEach(Recipe.sampleData) {recipe in
                    RecipeListItemView(recipe: recipe)
                }
            })
        } detail: {
            RecipeDetailView(recipe: selected!)
        }
    }
}

#Preview {
    ContentView()
}
