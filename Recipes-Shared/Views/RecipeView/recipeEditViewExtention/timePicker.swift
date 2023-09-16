//
//  timePicker.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-07-07.
//

import SwiftUI

struct timePicker: View {
    var title: String
    @Binding var H: Int
    @Binding var Min: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .light, design: .rounded))
            
            Picker("Hours", selection: $H) {
                ForEach(0..<25, id: \.self) { hour in
                    Text("\(hour) hours")
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            
            Picker("Minutes", selection: $Min) {
                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute) minutes")
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
        }
        .frame(height: 125)
    }
}
