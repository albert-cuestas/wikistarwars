//
//  Displaylable.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 9/2/22.
//

import Foundation

protocol Emptyable {
    static func empty() -> Self
}

protocol Typeable {
    var type: ElementType { get }
    static func typeElement() -> ElementType
}

extension Typeable {
    static func typeElement() -> ElementType {
        .none
    }
}

protocol ElementsUri {
    var url: String { get }
    var homeworldUri: String { get }
    var charactersUri: [String] { get }
    var filmsUri: [String] { get }
    var speciesUri: [String] { get }
    var vehiclesUri: [String] { get }
    var starshipsUri: [String] { get }
    var planetsUri: [String] { get }

    var hasCharacters: Bool { get }
    var hasFilms: Bool { get }
    var hasSpecies: Bool { get }
    var hasVehicles: Bool { get }
    var hasStarships: Bool { get }
    var hasPlanets: Bool { get }
}

extension ElementsUri {
    var homeworldUri: String {
        String.empty
    }

    var charactersUri: [String] {
        []
    }

    var filmsUri: [String] {
        []
    }

    var speciesUri: [String] {
        []
    }

    var vehiclesUri: [String] {
        []
    }

    var starshipsUri: [String] {
        []
    }

    var planetsUri: [String] {
        []
    }
}

protocol Displayable: Emptyable, Typeable, ElementsUri {
    static func empty() -> Self

    var identifier: UUID { get }
    var headline: String { get }
    var subHeadLine: String { get }
    var imageUri: String { get }
    var imageURL: URL? { get }
    func key() -> Int
}
