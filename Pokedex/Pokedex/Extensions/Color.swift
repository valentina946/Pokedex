//
//  Color+ChooseColorByString.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 27/5/23.
//

import Foundation
import SwiftUI

extension Color {
    
    static func chooseColor(name: String) -> Color {
        switch name {
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "brown":
            return Color.brown
        case "green":
            return Color.green
        case "yellow":
            return Color.yellow
        case "black":
            return Color(hex: 0x545059)
        case "white":
            return Color(hex: 0xDFDBDB)
        default :
            return Color(hex: 0x000000)
        }
    }
    
}

extension Color {
    
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
}
