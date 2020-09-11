//
//  DefinitionService.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/27/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

final class DefinitionService: NetworkService, DefinitionServiceProtocol {    
    
    func fetchSynonyms(word: String, success: @escaping (Synonym?) -> Void,
                     failure: @escaping (Error) -> Void) {
        let endpoint: DefinitionEndpoint = .synonym(word: word)
        request(endpoint: endpoint, success: { (response: Synonym) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
}
