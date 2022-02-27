//
//  SwApiService.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 5/2/22.
//

import Alamofire
import Foundation
import SwiftUI

final class SwApiService {
    static let shared = SwApiService()
    
    private enum SwApi {
        case allPeople(Int)
        case allStarShip(Int)
        case allFilms(Int)
        case allVehicles(Int)
        case allPlanets(Int)
        case allSpecies(Int)
        case imagePeople(Int)
        case imageSpecies(Int)
        case imageStarShip(Int)
        case imageFilms(Int)
        case imageVehicles(Int)
        case imagePlanets(Int)
        case searchPeople
        case searchStarship
        case searchFilms
        case searchVehicles
        case searchPlanets
        case searchSpecies
        
        private var name: String {
            switch self {
                case .allPeople(_), .searchPeople, .imagePeople:
                    return "people"
                case .allStarShip(_), .searchStarship, .imageStarShip:
                    return "starships"
                case .allFilms(_), .searchFilms, .imageFilms:
                    return "films"
                case .allVehicles(_), .searchVehicles, .imageVehicles:
                    return "vehicles"
                case .allPlanets(_), .searchPlanets, .imagePlanets:
                    return "planets"
                case .allSpecies(_), .searchSpecies, .imageSpecies:
                    return "species"
            }
        }
        
        func url() -> URL? {
            let apiUriBase = "https://swapi.py4e.com/api/" // "https://swapi.dev/api/" // "https://swapi.py4e.com/api/"//
            let apiUriImages = "https://starwars-visualguide.com/assets/img/$type/$id.jpg"
            
            switch self {
                case .allPeople(let page), .allStarShip(let page), .allFilms(let page), .allVehicles(let page), .allPlanets(let page), .allSpecies(let page):
                    return URL(string: "\(apiUriBase)\(name)?page=\(page)")
                case .imagePeople(let people):
                    return URL(string: "\(apiUriImages)"
                        .replacingOccurrences(of: "$type", with: "characters")
                        .replacingOccurrences(of: "$id", with: "\(people)"))
                case .imageSpecies(let value), .imageStarShip(let value), .imageFilms(let value), .imageVehicles(let value), .imagePlanets(let value):
                    return URL(string: "\(apiUriImages)"
                        .replacingOccurrences(of: "$type", with: "\(name)")
                        .replacingOccurrences(of: "$id", with: "\(value)"))
                case .searchPeople, .searchFilms, .searchStarship, .searchVehicles, .searchPlanets, .searchSpecies:
                    return URL(string: "\(apiUriBase)\(name)")
            }
        }
    }
    
    /// Valid url, is empty or end with "/api"
    /// - Parameter url: string for validate
    /// - Returns: true is not empty or not end with "/api"
    private func valid(url: String) -> Bool {
        url.isEmpty || url.hasSuffix("/api") || url.hasSuffix("/api/")
    }
    
    func imageUriBy(element: ElementType, value: Int) -> URL? {
        if value <= 0 {
            return nil
        }
        switch element {
            case .people:
                return SwApi.imagePeople(value).url()
            case .specie:
                return SwApi.imageSpecies(value).url()
            case .starShip:
                return SwApi.imageStarShip(value).url()
            case .film:
                return SwApi.imageFilms(value).url()
            case .vehicle:
                return SwApi.imageVehicles(value).url()
            case .planet:
                return SwApi.imagePlanets(value).url()
            default:
                return nil
        }
    }
    
    private func allUriBy(element: ElementType, page: Int) -> URL? {
        switch element {
            case .people:
                return SwApi.allPeople(page).url()
            case .homeworld:
                return SwApi.allPlanets(page).url()
            case .specie:
                return SwApi.allSpecies(page).url()
            case .starShip:
                return SwApi.allStarShip(page).url()
            case .film:
                return SwApi.allFilms(page).url()
            case .vehicle:
                return SwApi.allVehicles(page).url()
            case .planet:
                return SwApi.allPlanets(page).url()
            default:
                return nil
        }
    }
    
    private func searchUriBy(element: ElementType) -> URL? {
        switch element {
            case .people:
                return SwApi.searchPeople.url()
            case .homeworld:
                return SwApi.searchPlanets.url()
            case .specie:
                return SwApi.searchSpecies.url()
            case .starShip:
                return SwApi.searchStarship.url()
            case .film:
                return SwApi.searchFilms.url()
            case .vehicle:
                return SwApi.searchVehicles.url()
            case .planet:
                return SwApi.searchPlanets.url()
            default:
                return nil
        }
    }

    private func fetch<T: Decodable>(_ list: [String], of: T.Type, success: @escaping (_ value: [T]) -> Void) {
        var items: [T] = []
        let fetchGroup = DispatchGroup()
        
        list.forEach { url in
            fetchGroup.enter()
            AF.request(url).validate().responseDecodable(of: T.self) { response in
                if let value = response.value {
                    items.append(value)
                }
                fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            success(items)
        }
    }
    
    private func search<T: Decodable & Emptyable>(_ urlIn: URL?, of: T.Type = T.self, query: String, success: @escaping (_ value: T) -> Void) {
        var items = T.empty()
        var parameters: [String: String]?
        
        if !query.isEmpty {
            parameters = ["search": query]
        }
        
        guard let url = urlIn else { return success(T.empty()) }
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: T.self) { response in
            if let value = response.value {
                items = value
            }
            debugPrint(response.error ?? "No errors")
            success(items)
        }
    }
        
    func search<T: Decodable & Typeable & Emptyable>(query: String, success: @escaping (_ value: T) -> Void) {
        search(searchUriBy(element: T.typeElement()), query: query, success: success)
    }
    
    func all<T: Decodable & Typeable>(pageActive: Int? = 1, success: @escaping (_ items: T) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        let page = pageActive ?? 1
        
        guard let url = allUriBy(element: T.typeElement(), page: page) else {
            failure(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: T.self) { response in
            if let value = response.value {
                success(value)
            } else {
                failure(response.error)
            }
        }
    }
    
    func execute<T: Decodable>(url: String, success: @escaping (_ characters: T) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        if valid(url: url) {
            failure(AFError.invalidURL(url: url))
            return
        }
        AF.request(url).responseDecodable(of: T.self) { response in
            if let value = response.value {
                success(value)
            } else {
                failure(response.error)
            }
        }
    }
    
    func fetchFirstElement(url: String, success: @escaping (_ value: String) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        if url.isEmpty {
            success("unknown")
        }
        AF.request(url).responseJSON { json in
            switch json.result {
                case .success(let dataJson):
                    guard let data = (dataJson as? NSDictionary) else { return success("unknown") }
                    
                    guard let value = data["name"] as? String else { return success("unknown") }
                            
                    success(value)
                    
                case .failure(let error):
                    failure(error)
            }
        }
    }
    
    func fetchListOf<T: Decodable & Typeable>(url: [String], success: @escaping (_ value: [T]) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        fetch(url, of: T.self, success: success)
    }
}
