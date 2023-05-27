//
//  RecipeHeaderView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct RecipeHeaderView: View {
    var recipe: recipe
    var geo: GeometryProxy
    
    var body: some View {
        VStack {
            ImageView(image: Image("sample-Chocolate_Cookies"), backgroundColor: recipe.theme.mainColor)
                .ignoresSafeArea()
                .shadow(color: recipe.theme.mainColor, radius: 25)
            
            Text(recipe.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .fontDesign(.rounded)
            
            Spacer()
            RatingView(rating: recipe.rating ?? 0)
            
            ProprietiesView(recipe: recipe, geo: geo)
                .padding()
        }
    }
}

struct RecipeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            RecipeHeaderView(recipe: recipe.sampleData[0], geo: geo)
        }
    }
}
