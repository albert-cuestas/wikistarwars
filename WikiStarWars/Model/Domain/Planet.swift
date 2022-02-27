//
//  Planet.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Foundation

struct Planet: Codable, Hashable, Identifiable {
    internal init(_ emptyString: String) {
        self.name = emptyString
        self.rotationPeriod = emptyString
        self.orbitalPeriod = emptyString
        self.diameter = emptyString
        self.climate = emptyString
        self.gravity = emptyString
        self.terrain = emptyString
        self.surfaceWater = emptyString
        self.population = emptyString
        self.residents = [emptyString]
        self.films = [emptyString]
        self.created = emptyString
        self.edited = emptyString
        self.url = emptyString
    }
    
    internal init() {
        self.init(String.empty)
    }
    
    let id = UUID()
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

extension Planet: Displayable {
    var type: ElementType {
        .planet
    }
    
    var identifier: UUID {
        self.id
    }
    
    var headline: String {
        self.name
    }
    
    var subHeadLine: String {
        self.population
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
    
    static func empty() -> Planet {
        return .init()
    }
    
    static func typeElement() -> ElementType {
        .homeworld
    }
}

extension Planet: ElementsUri {
    var charactersUri: [String] {
        self.residents
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

extension Planet {
    static func sample() -> Planet? {
        let data = """
        {
        "name": "Tatooine",
        "rotation_period": "23",
        "orbital_period": "304",
        "diameter": "10465",
        "climate": "arid",
        "gravity": "1 standard",
        "terrain": "desert",
        "surface_water": "1",
        "population": "200000",
        "residents": [
        "https://swapi.dev/api/people/1/",
        "https://swapi.dev/api/people/2/",
        "https://swapi.dev/api/people/4/",
        "https://swapi.dev/api/people/6/",
        "https://swapi.dev/api/people/7/",
        "https://swapi.dev/api/people/8/",
        "https://swapi.dev/api/people/9/",
        "https://swapi.dev/api/people/11/",
        "https://swapi.dev/api/people/43/",
        "https://swapi.dev/api/people/62/"
        ],
        "films": [
        "https://swapi.dev/api/films/1/",
        "https://swapi.dev/api/films/3/",
        "https://swapi.dev/api/films/4/",
        "https://swapi.dev/api/films/5/",
        "https://swapi.dev/api/films/6/"
        ],
        "created": "2014-12-09T13:50:49.641000Z",
        "edited": "2014-12-20T20:58:18.411000Z",
        "url": "https://swapi.dev/api/planets/1/"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        var planet: Planet?
        do {
            planet = try decoder.decode(Planet.self, from: data)
            return planet!
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
