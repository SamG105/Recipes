//
//  Themes.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI
#if os(watchOS)

#endif

enum Theme: String, Identifiable, Codable, CaseIterable {
    case carrot
    case cake
    case muffin
    case peanutButter
    case magenta
    case bubblegum
    case lavender
    case orange
    case nuts
    case veggies
    case book
    case kitchen
    case cuisine
    
    var mainColor: Color {
        Color(rawValue)
    }
    var accentColor: Color {
        switch self {
        case .book, .bubblegum, .carrot, .cuisine, .kitchen, . lavender, .muffin, .orange, .peanutButter, .veggies: return .black
            
        case .cake, .magenta, .nuts: return .white
 
        }
    }
    
    var name: String {
        switch self {
        case .carrot:
            return "Carrot"
        case .cake:
            return "Cake"
        case .muffin:
            return "Muffin"
        case .peanutButter:
            return "Peanut butter"
        case .magenta:
            return "Magenta"
        case .bubblegum:
            return "Bubblegum"
        case .lavender:
            return "Lavender"
        case .orange:
            return "Orange"
        case .nuts:
            return "Nuts"
        case .veggies:
            return "Veggies"
        case .book:
            return "Book"
        case .kitchen:
            return "Kitchen"
        case .cuisine:
            return "Cuisine"
        }
    }
    var id: UUID{
        return UUID()
    }
}
