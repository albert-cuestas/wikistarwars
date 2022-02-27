//
//  Film.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 9/2/22.
//

import Foundation

struct Film: Codable, Hashable, Identifiable {
    internal init(_ emptyString: String) {
        self.title = emptyString
        self.episodeID = 0
        self.openingCrawl = emptyString
        self.director = emptyString
        self.producer = emptyString
        self.releaseDate = emptyString
        self.characters = [emptyString]
        self.planets = [emptyString]
        self.starships = [emptyString]
        self.vehicles = [emptyString]
        self.species = [emptyString]
        self.created = emptyString
        self.edited = emptyString
        self.url = emptyString
    }
    
    internal init() {
        self.init(String.empty)
    }
    
    let id = UUID()
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }
}

extension Film: Displayable {
    var type: ElementType {
        .film
    }
    
    var identifier: UUID {
        self.id
    }
    
    var headline: String {
        self.title
    }

    var subHeadLine: String {
        self.director
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
    
    static func empty() -> Film {
        return .init()
    }
    
    static func typeElement() -> ElementType {
        .film
    }
}

extension Film: ElementsUri {
    var charactersUri: [String] {
        self.characters
    }
    
    var speciesUri: [String] {
        self.species
    }
    
    var vehiclesUri: [String] {
        self.vehicles
    }
    
    var starshipsUri: [String] {
        self.starships
    }
    
    var planetsUri: [String] {
        self.planets
    }
    
    var hasCharacters: Bool { true }
    var hasFilms: Bool { false }
    var hasSpecies: Bool { false }
    var hasVehicles: Bool { true }
    var hasStarships: Bool { true }
    var hasPlanets: Bool { true }
}
