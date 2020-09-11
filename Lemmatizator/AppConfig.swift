//
//  AppConfig.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/27/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

enum AppConfiguration {
    
    private enum Paths {
        static let api = "api/v1/"
    }
    
    static let serverURL = URL(string: "https://dictionary.yandex.net")!
    static let apiKey = "dict.1.1.20200827T093150Z.1301e8a2e9b1fddf.6e49193b0e3b7f85f3bda93e7c7a5e7c6bed8b9f"
    static let font = "Avenir LT 55 Roman"
}
