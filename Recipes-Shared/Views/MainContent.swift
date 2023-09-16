//
//  MainContent.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-27.
//

import SwiftUI

struct MainContent: View {
    @Binding var recipes: [Recipe]
    let saveAction: ()->Void
    
    @Environment(\.horizontalSizeClass) var HScreenScheme
    
    var body: some View {
        if HScreenScheme == .compact {
            MainTabView(recipes: $recipes, saveAction: saveAction)
        } else {
            SplitView(recipes: $recipes, saveAction: saveAction)
        }
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContent(recipes: .constant(Recipe.sampleData), saveAction: {})
    }
}
