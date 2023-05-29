//
//  Constants.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation

public struct Constants {
    public struct Data {
        
        // MARK: - Textfield constants
        
        public static var BASE_URL = "https://pokeapi.co/api/v2/pokemon/"
        public static var currentURL = "\(BASE_URL)?limit=20&offset=0"
        public static var nextURL = ""
        public static var previousURL = ""
    }
}
