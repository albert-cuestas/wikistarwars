//
//  StarshipsRouter.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 20/2/22.
//

import Foundation

final class StarshipsRouter {
    static func view() -> StarshipsView {
        let router = StarshipsRouter()
        let viewModel = StarshipsViewModel(router: router)
        let view = StarshipsView(viewModel: viewModel)

        return view
    }
}
