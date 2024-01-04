//
//  Color.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 15/12/23.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}
struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let Green = Color("GreenColor")
    let Red = Color("RedColor")
    let Secondary = Color("SecondaryTextColor")
}
struct LaunchTheme{
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
