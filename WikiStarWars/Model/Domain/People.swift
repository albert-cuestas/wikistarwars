//
//  Characters.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 5/2/22.
//

import Foundation

struct People: Codable, Hashable, Identifiable {
    internal init(_ emptyString: String) {
        self.name = emptyString
        self.height = emptyString
        self.mass = emptyString
        self.hairColor = emptyString
        self.skinColor = emptyString
        self.eyeColor = emptyString
        self.birthYear = emptyString
        self.gender = emptyString
        self.homeworldUri = emptyString
        self.homeworld = emptyString
        self.filmsUri = [emptyString]
        self.speciesUri = [emptyString]
        self.vehiclesUri = [emptyString]
        self.starshipsUri = [emptyString]
        self.created = emptyString
        self.edited = emptyString
        self.url = emptyString
    }
    
    internal init() {
        self.init(String.empty)
    }
    
    let id = UUID()
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: String
    let homeworldUri: String
    var homeworld: String?
    let filmsUri, speciesUri, vehiclesUri, starshipsUri: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, created, edited, url
        case homeworldUri = "homeworld"
        case filmsUri = "films"
        case speciesUri = "species"
        case vehiclesUri = "vehicles"
        case starshipsUri = "starships"
    }
}

extension People: Displayable {
    var type: ElementType {
        .people
    }
    
    var identifier: UUID {
        self.id
    }
    
    var headline: String {
        self.name
    }
    
    var subHeadLine: String {
        self.gender
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
    
    static func empty() -> People {
        return .init()
    }
    
    static func typeElement() -> ElementType {
        .people
    }
}

extension People: ElementsUri {
    var hasCharacters: Bool { false }
    var hasFilms: Bool { true }
    var hasSpecies: Bool { true }
    var hasVehicles: Bool { true }
    var hasStarships: Bool { true }
    var hasPlanets: Bool { false }
}

extension People {
    static func sample() -> People? {
        let data = """
        {
                    "name": "Luke Skywalker",
                    "height": "172",
                    "mass": "77",
                    "hair_color": "blond",
                    "skin_color": "fair",
                    "eye_color": "blue",
                    "birth_year": "19BBY",
                    "gender": "male",
                    "homeworld": "",
                    "films": [
                        "https://swapi.dev/api/films/1/",
                        "https://swapi.dev/api/films/2/",
                        "https://swapi.dev/api/films/3/",
                        "https://swapi.dev/api/films/6/"
                    ],
                    "species": [],
                    "vehicles": [
                        "https://swapi.dev/api/vehicles/14/",
                        "https://swapi.dev/api/vehicles/30/"
                    ],
                    "starships": [
                        "https://swapi.dev/api/starships/12/",
                        "https://swapi.dev/api/starships/22/"
                    ],
                    "created": "2014-12-09T13:50:51.644000Z",
                    "edited": "2014-12-20T21:17:56.891000Z",
                    "url": "https://swapi.dev/api/people/1/"
                }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        var people: People?
        do {
            people = try decoder.decode(People.self, from: data)
            return people!
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
