//
//  ElementType.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 27/2/22.
//

import Foundation

enum ElementType {
    case people, homeworld, specie, starShip, film, vehicle, planet, none

    var title: String {
        switch self {
            case .people:
                return "Characters"
            case .homeworld:
                return "Homeworld"
            case .specie:
                return "Species"
            case .starShip:
                return "Starships"
            case .film:
                return "Films"
            case .vehicle:
                return "Vehicles"
            case .planet:
                return "Planet"
            case .none:
                return "Unknow"
        }
    }

    var imageError: String {
        switch self {
            case .people:
                return "person"
            case .homeworld:
                return "exclamationmark.octagon"
            case .specie:
                return "exclamationmark.octagon"
            case .starShip:
                return "exclamationmark.octagon"
            case .film:
                return "exclamationmark.octagon"
            case .vehicle:
                return "exclamationmark.octagon"
            case .planet:
                return "exclamationmark.octagon"
            case .none:
                return "exclamationmark.shield"
        }
    }

    var imageEmpty: String {
        switch self {
            case .people:
                return "person.circle.fill"
            case .homeworld:
                return "exclamationmark.octagon"
            case .specie:
                return "exclamationmark.octagon"
            case .starShip:
                return "exclamationmark.octagon"
            case .film:
                return "exclamationmark.octagon"
            case .vehicle:
                return "exclamationmark.octagon"
            case .planet:
                return "exclamationmark.octagon"
            case .none:
                return "exclamationmark.shield"
        }
    }
}
