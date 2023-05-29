//
//  TabView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct MainTabView: View {
    @Binding var recipes: [recipe]
    var body: some View {
        NavigationStack {
            TabView {
                recipeListView(recipes: $recipes)
                
                    .tabItem {
                        Label("Recipes", systemImage: "list.bullet")
                    }
                GroceryView(recipes: $recipes)
                    .tabItem {
                        Label("Grocery", systemImage: "list.bullet")
                    }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        
        MainTabView(recipes: .constant(recipe.sampleData))
    }
}
