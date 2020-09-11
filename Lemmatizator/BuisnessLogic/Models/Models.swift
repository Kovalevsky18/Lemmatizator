//
//  Models.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/27/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

struct Synonym: Codable {
    let head: Head
    let def: [Def]
}

// MARK: - Def
struct Def: Codable {
       let tr: [Tr]
}

// MARK: - Tr
struct Tr: Codable {
    let text, pos: String
    let syn: [Syn]?
}

// MARK: - Syn
struct Syn: Codable {
    let text: String
    let pos: String
}

// MARK: - Head
struct Head: Codable {
}
