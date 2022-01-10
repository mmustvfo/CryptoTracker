//
//  ColorTheme.swift
//  CtyptoTracker
//
//  Created by Mustafo on 29/05/21.
//

import Foundation
import SwiftUI

extension Color {
    static let colorTheme = ColorThemes()
    static let launchScreenColors = LaunchScreenColors()
}

struct ColorThemes {
    let accentColor = Color("AccentColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let background = Color("BackgroundColor")
    let secondaryTextColor = Color("SecondaryTextColor")
    
}

struct LaunchScreenColors {
    let accent = Color("Accent")
    let background = Color("Background")
}
