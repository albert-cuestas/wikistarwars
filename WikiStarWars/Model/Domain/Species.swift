//
//  Species.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Foundation

struct Species: Decodable {
    var next: String?
    var previous: String?
    let count: Int
    let results: [Specie]?
}

extension Species: Emptyable {
    static func empty() -> Species {
        .init(next: nil, previous: nil, count: 0, results: nil)
    }
}

extension Species: Typeable {
    var type: ElementType {
        .specie
    }

    static func typeElement() -> ElementType {
        .specie
    }
}
