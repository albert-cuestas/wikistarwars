//
//  VehiclesRouter.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 24/2/22.
//

import Foundation

final class VehiclesRouter {
    static func view() -> VehiclesView {
        let router = VehiclesRouter()
        let viewModel = VehiclesViewModel(router: router)
        let view = VehiclesView(viewModel: viewModel)

        return view
    }
}
