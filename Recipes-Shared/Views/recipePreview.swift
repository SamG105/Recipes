//
//  recipePreview.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct recipePreview: View {
    var recipe: recipe
    var body: some View {
        VStack {
            Text(recipe.name)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack {
                Label("\((recipe.preparationTime.hours ?? 0) + (recipe.cookingTime.hours ?? 0) + (recipe.chillingTime.hours ?? 0))h \((recipe.preparationTime.minutes ?? 0) + (recipe.cookingTime.minutes ?? 0) + (recipe.chillingTime.minutes ?? 0))min", systemImage: "clock")
                    .padding(.leading, 20)
                Spacer()
                RatingView(rating: recipe.rating ?? 0)
                Spacer()
            }
        }
        .minimumScaleFactor(0.8)
        //.padding()
        //.background(recipe.theme.mainColor)
        .cornerRadius(10)
        .foregroundColor(recipe.theme.accentColor)
    }
}

struct recipePreview_Previews: PreviewProvider {
    static var previews: some View {
        recipePreview(recipe: recipe.sampleData[0])
    }
}
