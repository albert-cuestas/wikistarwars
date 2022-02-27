//
//  StarShip.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 8/2/22.
//

import Foundation

struct Starhip: Codable, Hashable, Identifiable {
    internal init(_ emptyString: String) {
        self.name = emptyString
        self.model = emptyString
        self.manufacturer = emptyString
        self.costInCredits = emptyString
        self.length = emptyString
        self.maxAtmospheringSpeed = emptyString
        self.crew = emptyString
        self.passengers = emptyString
        self.cargoCapacity = emptyString
        self.consumables = emptyString
        self.hyperdriveRating = emptyString
        self.mglt = emptyString
        self.starshipClass = emptyString
        self.pilots = [emptyString]
        self.films = [emptyString]
        self.created = emptyString
        self.edited = emptyString
        self.url = emptyString
    }
    
    internal init() {
        self.init(String.empty)
    }
    
    let id = UUID()
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables, hyperdriveRating, mglt: String
    let starshipClass: String
    let pilots: [String]
    let films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case starshipClass = "starship_class"
        case pilots, films, created, edited, url
    }
}

extension Starhip: Displayable {
    var type: ElementType {
        .starShip
    }
    
    var identifier: UUID {
        self.id
    }
    
    var headline: String {
        self.name
    }
    
    var subHeadLine: String {
        self.model
    }
    
    var imageUri: String {
        self.url
    }
    
    var imageURL: URL? {
        SwApiService.shared.imageUriBy(element: self.type, value: self.key())
    }
    
    func key() -> Int {
        guard let key = self.url.split(separator: "/").last else { return 0 }
        
        let value = Int(key) ?? 0
        return value
    }
    
    static func empty() -> Starhip {
        return .init() 
    }
    
    static func typeElement() -> ElementType {
        .starShip
    }
}

extension Starhip: ElementsUri {
    var charactersUri: [String] {
        self.pilots
    }
    
    var filmsUri: [String] {
        self.films
    }
    
    var hasCharacters: Bool { true }
    var hasFilms: Bool { false }
    var hasSpecies: Bool { false }
    var hasVehicles: Bool { false }
    var hasStarships: Bool { false }
    var hasPlanets: Bool { false }
}
