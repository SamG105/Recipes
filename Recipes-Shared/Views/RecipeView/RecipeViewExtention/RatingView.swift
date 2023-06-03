//
//  RatingView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-27.
//
import SwiftUI

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Image(systemName: getStarSymbol(index: index))
                    .foregroundColor(getStarColor(index: index))
            }
        }
    }
    
    func getStarSymbol(index: Int) -> String {
        let filledStarCount = Int(rating * 5)
        
        if index < filledStarCount {
            return "star.fill"
        } else if index == filledStarCount && rating - Double(filledStarCount) >= 0.5 {
            return "star.leadinghalf.fill"
        } else {
            return "star"
        }
    }
    
    func getStarColor(index: Int) -> Color {
        let filledStarCount = Int(rating * 5)
        
        if index < filledStarCount || (index == filledStarCount && rating - Double(filledStarCount) >= 0.5) {
            return .yellow
        } else {
            return .gray
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 0.6)
    }
}
