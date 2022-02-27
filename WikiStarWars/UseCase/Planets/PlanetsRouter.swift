//
//  PlanetsRouter.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 23/2/22.
//

import Foundation

final class PlanetsRouter {
    static func view() -> PlanetsView {
        let router = PlanetsRouter()
        let viewModel = PlanetsViewModel(router: router)
        let view = PlanetsView(viewModel: viewModel)

        return view
    }
}
