//
//  StepsView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct StepsView: View {
    @Binding var recipe: recipe
    
    var body: some View {
        VStack {
            ForEach($recipe.steps) {step in
                StepView(step: step, theme: recipe.theme)
                    .padding(.vertical, -2)
            }
        }
        .cornerRadius(15)
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView(recipe: .constant(recipe.sampleData[0]))
    }
}
