//
//  StringExtension.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 19/2/22.
//

import Foundation
import UIKit

extension String {
    static let empty = String()

    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    func heightForView( fontName: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: fontName, size: fontSize)
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    func heightFrom() -> CGFloat {
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)
        let textFirstLine: UILabel = .init()
        textFirstLine.text = "A"
        textFirstLine.font = font
        return CGFloat(self.split(whereSeparator: \.isNewline).count+2) * 28.0
    }
}
