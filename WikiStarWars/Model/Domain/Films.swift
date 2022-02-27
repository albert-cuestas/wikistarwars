//
//  Films.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation

struct Films: Decodable {
    var next: String?
    var previous: String?
    let count: Int
    let results: [Film]?
}

extension Films: Emptyable {
    static func empty() -> Films {
        .init(next: nil, previous: nil, count: 0, results: nil)
    }
}

extension Films: Typeable {
    var type: ElementType {
        .film
    }

    static func typeElement() -> ElementType {
        .film
    }
}
