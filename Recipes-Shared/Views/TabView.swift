//
//  TabView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct MainTabView: View {
    @Binding var recipes: [Recipe]
    @State private var isPresentingNewRecipeView = false
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    @State var newRecipe = Recipe.emptyRecipe
    
    var body: some View {
        //NavigationStack {
        TabView {
            recipeListView(recipes: $recipes, isPresentingNewRecipeView: $isPresentingNewRecipeView)
                .tabItem {
                    Label("Recipes", systemImage: "text.book.closed.fill")
                }
            
            PublicStoreView()
                .tabItem {
                    Label("Store", systemImage: "list.bullet.below.rectangle")
                }
            
            FavoritesView(recipes: $recipes)
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }
            GroceryView(recipes: $recipes)
                .tabItem {
                    Label("Grocery", systemImage: "list.bullet")
                }
        }
        //}
        .sheet(isPresented: $isPresentingNewRecipeView) {
            NewRecipeView(recipes: $recipes, isPresentingNewRecipeView: $isPresentingNewRecipeView)
        }
        .onChange(of: scenePhase) {phase in
            if phase == .inactive {saveAction()}
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(recipes: .constant(Recipe.sampleData), saveAction: {})
    }
}
