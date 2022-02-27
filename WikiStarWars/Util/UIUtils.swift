//
//  Utils.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 4/2/22.
//

import UIKit

final class UIUtils {
    public static func parseNumberFormatString(_ value: String, unit: String) -> String {
        if !value.isEmpty {
            if value.contains("n/a") ||
                value.contains("unknown")
            {
                return value
            }

            guard let val = Int(value) else { return value }

            return "\(val)\(unit)"
        }
        return value
    }
}
