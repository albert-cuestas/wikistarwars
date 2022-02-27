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

protocol Displayable: Emptyable, Typeable {
    var identifier: UUID { get }
    var headline: String { get }
    var subHeadLine: String { get }
    var imageUri: String { get }
    var imageURL: URL? { get }
    func key() -> Int
    static func empty() -> Self
}
