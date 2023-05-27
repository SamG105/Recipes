//
//  StepView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//

import SwiftUI

struct StepView: View {
    @Binding var step: recipe.step
    var theme: Theme
    
    var body: some View {
        HStack {
            Button {
                step.isDone.toggle()
            } label: {
                Image(systemName: step.isDone ? "checkmark.diamond.fill" : "diamond")
                    .foregroundColor(theme.accentColor)
            }
            
            Text(step.text)
                .foregroundColor(step.isDone ? theme.accentColor.opacity(0.5) : theme.accentColor)
            Spacer()
        }
        .padding(10)
        .background(theme.mainColor)
        .cornerRadius(5)
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(step: .constant(recipe.sampleData[0].steps[0]), theme: .peanutButter)
    }
}
