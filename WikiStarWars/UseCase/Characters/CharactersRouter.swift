//

//  CharactersRouter.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation

final class CharactersRouter {
    static func view() -> CharactersView {
        let router = CharactersRouter()
        let viewModel = CharactersViewModel(router: router)
        let view = CharactersView(viewModel: viewModel)

        return view
    }
}
