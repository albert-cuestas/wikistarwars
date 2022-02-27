//
//  Vehicle.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 9/2/22.
//

import Foundation

struct Vehicle: Codable, Hashable, Identifiable {
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
        self.vehicleClass = emptyString
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
    let cargoCapacity, consumables, vehicleClass: String
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
        case vehicleClass = "vehicle_class"
        case pilots, films, created, edited, url
    }
}

extension Vehicle: Displayable {
    var type: ElementType {
        .vehicle
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
    
    static func empty() -> Vehicle {
        return .init()
    }
    
    static func typeElement() -> ElementType {
        .vehicle
    }
}

extension Vehicle: ElementsUri {
    var charactersUri: [String] {
        self.pilots
    }
    
    var filmsUri: [String] {
        self.films
    }
    
    var hasCharacters: Bool { true }
    var hasFilms: Bool { true }
    var hasSpecies: Bool { false }
    var hasVehicles: Bool { false }
    var hasStarships: Bool { false }
    var hasPlanets: Bool { false }
}

extension Vehicle {
    static func sample() -> Vehicle? {
        let data = """
        {
        "name": "Snowspeeder",
        "model": "t-47 airspeeder",
        "manufacturer": "Incom corporation",
        "cost_in_credits": "unknown",
        "length": "4.5",
        "max_atmosphering_speed": "650",
        "crew": "2",
        "passengers": "0",
        "cargo_capacity": "10",
        "consumables": "none",
        "vehicle_class": "airspeeder",
        "pilots": [
        "https://swapi.dev/api/people/1/",
        "https://swapi.dev/api/people/18/"
        ],
        "films": [
        "https://swapi.dev/api/films/2/"
        ],
        "created": "2014-12-15T12:22:12Z",
        "edited": "2014-12-20T21:30:21.672000Z",
        "url": "https://swapi.dev/api/vehicles/14/"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        var vehicle: Vehicle?
        do {
            vehicle = try decoder.decode(Vehicle.self, from: data)
            return vehicle!
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
