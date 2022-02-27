//
//  Characters.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 12/2/22.
//

import Foundation

struct Characters: Decodable {
    var next: String?
    var previous: String?
    let count: Int
    let results: [People]?
}

extension Characters: Emptyable {
    static func empty() -> Characters {
        .init(next: nil, previous: nil, count: 0, results: nil)
    }
}

extension Characters: Typeable {
    var type: ElementType {
        .people
    }

    static func typeElement() -> ElementType {
        .people
    }
}
