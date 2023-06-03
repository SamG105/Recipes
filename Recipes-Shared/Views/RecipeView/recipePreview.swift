//
//  recipePreview.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct recipePreview: View {
    @Binding var recipe: Recipe
    var body: some View {
        VStack {
            Text(recipe.name)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack {
                Label("\((recipe.preparationTime.hours ) + (recipe.cookingTime.hours ) + (recipe.chillingTime.hours ))h \((recipe.preparationTime.minutes ) + (recipe.cookingTime.minutes ) + (recipe.chillingTime.minutes ))min", systemImage: "clock")
                    //.padding(.leading, 20)
                Spacer()
                RatingView(rating: recipe.rating )
                //Spacer()
                Button{
                    recipe.isFavorite.toggle()
                } label: {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(recipe.isFavorite ? .red : .black)
                }
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
        recipePreview(recipe: .constant(Recipe.sampleData[0]))
            .frame(height: 10)
    }
}
