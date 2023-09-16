//
//  SplitView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-27.
//

import SwiftUI

struct SplitView: View {
    @Binding var recipes: [Recipe]
    @State private var isPresentingNewRecipeView = false
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    @State var newRecipe = Recipe.emptyRecipe
    @State var NavColumnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $NavColumnVisibility) {
            List {
                makeLinkFor("My Recipes", ImageName: "text.book.closed.fill", Destination:  recipeListView(recipes: $recipes, isPresentingNewRecipeView: $isPresentingNewRecipeView))
                    .foregroundColor(.brown)
                makeLinkFor("Store", ImageName: "list.bullet.below.rectangle", Destination: PublicStoreView())
                    .foregroundColor(.blue)
                makeLinkFor("Favourites", ImageName: "heart.fill", Destination: FavoritesView(recipes: $recipes))
                    .foregroundColor(.red)
                makeLinkFor("Grocery", ImageName: "list.bullet", Destination: GroceryView(recipes: $recipes))
                    .foregroundColor(.blue)
                
            }
        } detail: {
            Text("Detail")
        }
        .navigationSplitViewStyle(.balanced)
    }
    
    func makeLinkFor(_ Name: String, ImageName: String, Destination: some View) -> some View {
        NavigationLink(destination: Destination) {
            HStack{
                //Label("Recipes", systemImage: "text.book.closed.fill")
                Image(systemName: ImageName)
                Text(Name)
                    .foregroundColor(.black)
            }
        }
    }
    
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(recipes: .constant(Recipe.sampleData), saveAction: {})
    }
}
