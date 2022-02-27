//
//  HomeViewModel.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 4/2/22.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    private let router: HomeRouter

    init(router: HomeRouter) {
        self.router = router
    }
}
