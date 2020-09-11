//
//  DefinitionEndpoint.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/27/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

enum DefinitionEndpoint {
    case synonym(word: String)
}

enum PathEndpoint {
    case dictionary
}

extension DefinitionEndpoint: Endpoint {
    
    var baseURL: URL {
        AppConfiguration.serverURL
    }
    
    var path: String {
        switch self {
        case .synonym( _):
            return "dicservice.json/lookup"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .synonym(let word):
            return ["client_id": AppConfiguration.apiKey,
                    "text": "\(word)",
                "lang": "en-en"]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : Any] {
        [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return .URLEncoding
    }
}


