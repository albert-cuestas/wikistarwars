//
//  SpeciesRouter.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 24/2/22.
//

import Foundation

final class SpeciesRouter {
    static func view() -> SpeciesView {
        let router = SpeciesRouter()
        let viewModel = SpeciesViewModel(router: router)
        let view = SpeciesView(viewModel: viewModel)
        
        return view
    }
}
