//
//  ColorExtension.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let backgroundColor = Color(red: 0.1, green: 0.1, blue: 0.2)
    static let lightbackgroundColor =  Color(red: 0.2, green: 0.2, blue: 0.3)
    static let textColor = Color("TextColor")
    static let secondaryDark = Color.gray
    static let starWarsColor = Color("StarWarsColor")
    
    var uiColor: UIColor {
        return UIColor(self)
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red*255, green*255, blue*255, alpha)
    }
    

    
}
