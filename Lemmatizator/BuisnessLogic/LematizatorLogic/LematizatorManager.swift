//
//  LematizatorManager.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/19/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

class LematizatorManager {
    
    static func lemmatizator(title: String) {
        let privateChildContext = PersistenceManager.shared.privateChildContext
        privateChildContext.parent = PersistenceManager.shared.context
        
        privateChildContext.performAndWait {
            let lem = Lemmatizator()
            guard let res = lem.readBook(title) else { return }
            guard let lemmatized = lem.lemmatizeWords(res, in: 0..<res.words.count) else { return }
            
            var stats: [String:Int] = [:]
            
            for stem in lemmatized {
                if let count = stats[stem] {
                    stats[stem] = count + 1
                } else {
                    stats[stem] = 1
                }
            }
            
            let tuples = stats.map{ ($0, $1) }.sorted{ $0.0 < $1.0 }.sorted{ $0.1 < $1.1 }
            let median = Int(floor(Double(tuples.count) / 2.0))
            
            PersistenceManager.shared.saveBook(title: title, minWord: tuples.first!.0, maxWord: tuples.last!.0, medianWord: tuples[median].0, word: tuples)
        }
    }
}
