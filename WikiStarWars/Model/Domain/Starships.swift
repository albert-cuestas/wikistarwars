//
//  Starships.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Foundation

struct Starships: Decodable {
    var next: String?
    var previous: String?
    let count: Int
    let results: [Starhip]?
}

extension Starships: Emptyable {
    static func empty() -> Starships {
        .init(next: nil, previous: nil, count: 0, results: nil)
    }
}

extension Starships: Typeable {
    var type: ElementType {
        .starShip
    }

    static func typeElement() -> ElementType {
        .starShip
    }
}
