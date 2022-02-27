//
//  Categories.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation
import SwiftUI

enum Categories: CaseIterable {
    case characters, films, planets, species, starships, vehicles

    var name: String {
        switch self {
            case .characters:
                return "Characters"
            case .films:
                return "Films"
            case .planets:
                return "Planets"
            case .species:
                return "Species"
            case .starships:
                return "Starships"
            case .vehicles:
                return "Vehicles"
        }
    }
    
    var icon: String {
        switch self {
            case .characters:
                return "character"
            case .films:
                return "films"
            case .planets:
                return "planets"
            case .species:
                return "species"
            case .starships:
                return "starships"
            case .vehicles:
                return "vehicles"
        }
    }
    
    var destination: AnyView {
        switch self {
            case .characters:
                return AnyView(CharactersRouter.view())
            case .films:
                return AnyView(FilmsRouter.view())
            case .planets:
                return AnyView(CharactersRouter.view())
            case .species:
                return AnyView(CharactersRouter.view())
            case .starships:
                return AnyView(CharactersRouter.view())
            case .vehicles:
                return AnyView(CharactersRouter.view())
        }
    }
}
