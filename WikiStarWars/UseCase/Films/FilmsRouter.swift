//
//  FilmsRouter.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation

final class FilmsRouter {
    static func view() -> FilmsView {
        let router = FilmsRouter()
        let viewModel = FilmsViewModel(router: router)
        let view = FilmsView(viewModel: viewModel)

        return view
    }
}
