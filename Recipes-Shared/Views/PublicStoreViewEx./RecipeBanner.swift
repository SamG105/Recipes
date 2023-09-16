//
//  RecipeBanner.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-08.
//

import SwiftUI

struct RecipeBanner: View {
    var recipe: Recipe
    
    var body: some View {
        
        ZStack {
            Image(uiImage: recipe.image ?? UIImage())
                .scaledToFit()
            //.frame(width: geo.size.width, height: 200)
                .clipped()
                .scaledToFit()
                .padding(.top, -50)
            
            LinearGradient(gradient: Gradient(colors: [.white, recipe.theme.mainColor.opacity(0), recipe.theme.mainColor.opacity(0.5), recipe.theme.mainColor]), startPoint: .top, endPoint: .bottom)
            //.frame(height: 200)
            
            /*VStack {
                Spacer()
                HStack {
                    Text(recipe.name)
                        .font(.headline)
                }
                .foregroundColor(recipe.theme.accentColor)
                .padding(.bottom)
            }*/
        }
        .frame(height: (recipe.image?.size.height ?? 250) - 50)
        .cornerRadius(50)
        //.frame(height: 5)
    }
    
}

struct RecipeBanner_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBanner(recipe: Recipe.sampleData[0])
    }
}
