//
//  ErrorWrapper.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-06-03.
//

import Foundation
#if os(watchOS)
#endif

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
