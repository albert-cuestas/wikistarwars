//
//  Utils.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 4/2/22.
//

import UIKit

final class UIUtils {

    public func parseNumberFormatString(_ value: String, unit: String) -> String {
        if !value.isEmpty {
            let val = Int(value)
            if val != nil {
                return "\(value)\(unit)"
            }
        }
        return value
    }
}
