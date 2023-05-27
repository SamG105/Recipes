//
//  ImageView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-24.
//

import SwiftUI

struct ImageView: View {
    var image: Image
    var backgroundColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor
            
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(50)
                .padding(10)
                
        }
        .cornerRadius(50)
    }
}

struct ImageView_Previews: PreviewProvider {
    static let tester = recipe.sampleData[0]
    static var previews: some View {
        ImageView(image: Image("sample-Chocolate_Cookies"), backgroundColor: tester.theme.mainColor)
    }
}
