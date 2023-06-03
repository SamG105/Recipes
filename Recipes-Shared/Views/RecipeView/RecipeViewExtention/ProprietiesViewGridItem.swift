//
//  ProprietiesViewGridItem.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-24.
//

import SwiftUI

extension ProprietiesView {
    struct gridItemView: View {
        var topText: String
        var bottomText: String?
        var time: Recipe.time?
        var theme: Theme
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(topText)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    if let BText = bottomText {
                        Text(BText)
                            .font(.headline)
                    }
                    
                    if let time = time {
                        HStack {
                            if let Hrs = time.hours {
                                if Hrs != 0 {
                                    Text("\(Hrs) H")
                                        .font(.headline)
                                }
                            }
                            if let Min = time.minutes {
                                if Min != 0 {
                                    Text("\(Min) min")
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                Rectangle()
                    .frame(width: 1.5, height: 40)
                    .cornerRadius(1)
                    .foregroundColor(theme.mainColor)
            }
        }
    }
}
struct ProprietiesViewGridItem_Previews: PreviewProvider {
    static var previews: some View {
        ProprietiesView.gridItemView(topText: "Quantity", time: Recipe.time(hours: 1, minutes: 2), theme: .peanutButter)
            .frame(width: 125, height: 50)
    }
}
