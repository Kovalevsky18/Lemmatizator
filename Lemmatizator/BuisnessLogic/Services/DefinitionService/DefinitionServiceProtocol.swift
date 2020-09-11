//
//  DefinitionProtocol.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/27/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

protocol  DefinitionServiceProtocol: class {
    
   func fetchSynonyms(word: String, success: @escaping (Synonym?) -> Void,
                     failure: @escaping (Error) -> Void)
}
