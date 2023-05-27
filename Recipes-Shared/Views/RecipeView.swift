//
//  ContentView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: recipe
    
    var body: some View {
        GeometryReader {geo in
            ScrollView {
                VStack {
                    RecipeHeaderView(recipe: recipe, geo: geo)
                    
                    Spacer()
                    Text(recipe.description)
                    Spacer()
                    
                    IngredientsView(recipe: $recipe)
                        .frame(width: geo.size.width - 30)
                        .padding()
                    
                    Rectangle()
                        .frame(width: geo.size.width - 30, height: 2)
                        .cornerRadius(1)
                        .foregroundColor(recipe.theme.mainColor)
                    
                    StepsView(recipe: $recipe)
                        .padding()
                    
                    TextField("Notes", text: $recipe.notes, prompt: Text("Add Your personal notes"))
                        .padding()
                    
                    if let link = recipe.link {
                        Link(destination: link) {
                            Text("Go to Website")
                        }
                    }
                }
            }
            //.ignoresSafeArea()
        }
        .offset(y: -40)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .constant(recipe.sampleData[0]))
    }
}
