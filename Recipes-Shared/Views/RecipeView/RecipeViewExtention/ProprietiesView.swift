//
//  ProprietiesView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-24.
//

import SwiftUI

struct ProprietiesView: View {
    var recipe: Recipe
    var geo: GeometryProxy
    
    var body: some View {
        //GeometryReader {geo in
            LazyVGrid(columns: makeGridIn(ScreenWidth: geo.size.width)) {
                gridItemView(topText: "Preparation Time", time: recipe.preparationTime ,theme: recipe.theme)
                    .frame(width: 130)
                gridItemView(topText: "Cooking Time", time: recipe.cookingTime ,theme: recipe.theme)
                    .frame(width: 130)
                gridItemView(topText: "Chilling Time", time: recipe.chillingTime ,theme: recipe.theme)
                    .frame(width: 130)
                gridItemView(topText: "Makes", bottomText: "\(recipe.portion.value) \(recipe.portion.unit)" ,theme: recipe.theme)
                    .frame(width: 130)
                gridItemView(topText: "Freezes", bottomText: recipe.canFreeze.asString() ,theme: recipe.theme)
                    .frame(width: 130)
            }
            //.frame(height: height(screenWidth: geo.size.width))
        }
    //}
    
    func height(screenWidth: CGFloat) -> CGFloat {
        let numberOfRows = makeGridIn(ScreenWidth: screenWidth).count
        if numberOfRows == 5 {
            return 50
        } else if numberOfRows == 4 || numberOfRows == 3 {
            return 100
        } else if numberOfRows == 2{
            return 150
        } else {
            return 200
        }
    }
    
    func makeGridIn(ScreenWidth: CGFloat) -> [GridItem] {
        let numberOfItems: Int = Int(ScreenWidth / 150)
        let array: Array = Array(repeating: GridItem(.flexible(minimum: 110)), count: numberOfItems)
        return array//[GridItem(), GridItem()]
    }
}

struct ProprietiesView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ProprietiesView(recipe: Recipe.sampleData[0], geo: geo)
        }
    }
}
