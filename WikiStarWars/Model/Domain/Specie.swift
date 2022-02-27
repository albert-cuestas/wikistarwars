//
//  Specie.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Foundation

struct Specie: Codable, Hashable, Identifiable {
    internal init(_ emptyString: String) {
        self.name = emptyString
        self.classification = emptyString
        self.designation = emptyString
        self.averageHeight = emptyString
        self.skinColors = emptyString
        self.hairColors = emptyString
        self.eyeColors = emptyString
        self.averageLifespan = emptyString
        self.homeworld = emptyString
        self.language = emptyString
        self.people = [emptyString]
        self.films = [emptyString]
        self.created = emptyString
        self.edited = emptyString
        self.url = emptyString
    }
    
    internal init() {
        self.init(String.empty)
    }
    
    let id = UUID()
    let name, classification, designation, averageHeight: String
    let skinColors, hairColors, eyeColors, averageLifespan: String
    let homeworld: String?
    let language: String
    let people, films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, classification, designation
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeworld, language, people, films, created, edited, url
    }
}

extension Specie: Displayable {
    var type: ElementType {
        .specie
    }
    
    var identifier: UUID {
        self.id
    }
    
    var headline: String {
        self.name
    }
    
    var subHeadLine: String {
        self.classification
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
    
    static func empty() -> Specie {
        return .init()
    }
    
    static func typeElement() -> ElementType {
        .specie
    }
}

extension Specie:ElementsUri {

    var charactersUri: [String] {
        self.people
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

extension Specie {
    static func sample() -> Specie? {
        let data = """
        {
        "name": "Human",
        "classification": "mammal",
        "designation": "sentient",
        "average_height": "180",
        "skin_colors": "caucasian, black, asian, hispanic",
        "hair_colors": "blonde, brown, black, red",
        "eye_colors": "brown, blue, green, hazel, grey, amber",
        "average_lifespan": "120",
        "homeworld": "https://swapi.dev/api/planets/9/",
        "language": "Galactic Basic",
        "people": [
        "https://swapi.dev/api/people/66/",
        "https://swapi.dev/api/people/67/",
        "https://swapi.dev/api/people/68/",
        "https://swapi.dev/api/people/74/"
        ],
        "films": [
        "https://swapi.dev/api/films/1/",
        "https://swapi.dev/api/films/2/",
        "https://swapi.dev/api/films/3/",
        "https://swapi.dev/api/films/4/",
        "https://swapi.dev/api/films/5/",
        "https://swapi.dev/api/films/6/"
        ],
        "created": "2014-12-10T13:52:11.567000Z",
        "edited": "2014-12-20T21:36:42.136000Z",
        "url": "https://swapi.dev/api/species/1/"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        var specie: Specie?
        do {
            specie = try decoder.decode(Specie.self, from: data)
            return specie!
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
