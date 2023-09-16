//
//  RecipeDetailView.swift
//  Recipes-Watch Watch App
//
//  Created by Samuel Guay on 2023-08-03.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @State var selection: Text = ""
    var body: some View {
        TabView(selection: $selection) {
            Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
            Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
        }
    }
}

#Preview {
    RecipeDetailView()
}
