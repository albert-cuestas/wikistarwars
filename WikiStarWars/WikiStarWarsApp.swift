//
//  WikiStarWarsApp.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 4/2/22.
//

import SwiftUI

@main
struct WikiStarWarsApp: App {
    internal init() {
        
        // UINavigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundImage = UIImage()
        navigationBarAppearance.backgroundColor = Color.backgroundColor.uiColor
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.clear,
            .font: UIFont(descriptor: UIFontDescriptor(name: "Starjedi", size: 18), size: 18)
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: Color.starWarsColor.uiColor,
            .font: UIFont(descriptor: UIFontDescriptor(name: "Starjedi", size: 34), size: 34)
        ]
        
        // Make all buttons with green text.
        let buttonAppearance = UIBarButtonItemAppearance()
        let buttonAppTitleText: [NSAttributedString.Key: Any] = [.foregroundColor: Color.starWarsColor.uiColor, .font: UIFont(descriptor: UIFontDescriptor(name: "Starjedi", size: 12.7), size: 12.7)]
        let buttonAppearanceNormal: UIBarButtonItemStateAppearance = buttonAppearance.normal
        buttonAppearanceNormal.titleTextAttributes = buttonAppTitleText
        buttonAppearance.highlighted.titleTextAttributes = buttonAppTitleText
        buttonAppearance.focused.titleTextAttributes = buttonAppTitleText
        
        navigationBarAppearance.buttonAppearance = buttonAppearance
        UINavigationBar.appearance().compactAppearance?.buttonAppearance = buttonAppearance // For iPhone small navigation bar in landscape.
        
        let backIndicatorImage = UIImage(systemName: "arrow.backward")
        navigationBarAppearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorImage)
        
        UINavigationBar.appearance().tintColor = Color.starWarsColor.uiColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Color.backgroundColor.uiColor
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            HomeRouter.view().background(Color.backgroundColor).statusBar(hidden: false)
        }
    }
}
