//
//  Lemmatizator.swift
//  Lemmatizator
//
//  Created by g00dm0us3 on 8/17/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation
import NaturalLanguage

struct BookText {
    let text: String
    let words: [String]
    var wordCount: Int {
        return words.count
    }
}

final class Lemmatizator {
    private var stopWords = Set<String>()
    private let allowedSymbols = "abcdefghijklmnopqrstuvwxyz,. ?!\"':;()&-"
    
    init() {
        loadStopWords()
    }
    
    // MARK: Public Indicency
    func readBook(_ bookName: String) -> BookText? {
        guard var text = readFile(bookName, withExtension: "txt") else { print("😱 Couldn't read book!"); return nil }
        text = text.lowercased().filter{ allowedSymbols.contains($0) }
        
        var words = [String]()
        text.enumerateSubstrings(in: text.startIndex..., options: .byWords) { _, range, _, _ in
            words.append(String(text[range]))
        }
        print("🤓 I read \(bookName). Feels like \(words.count) words.")
        return BookText(text: text, words: words)
    }
    
    func lemmatizeWords(_ fromText: BookText, in range: Range<Int>) -> [String]? {
        guard range.clamped(to: fromText.words.startIndex..<fromText.words.endIndex) == range else { print("😱 \(range) is invalid range! the valid range should be in [0..<(\(fromText.words.count)]"); return nil }
        
        var lemmatized = [String]()
        let tagger = NLTagger(tagSchemes: [.lemma])
    
        let start = DispatchTime.now()
        print("🤓 Started lemmatizing \(range.endIndex - range.startIndex + 1) words")

        for idx in range {
            let word = fromText.words[idx]
            tagger.string = word
            tagger.setLanguage(.english, range: word.startIndex..<word.endIndex)
            let res = tagger.tag(at: word.startIndex, unit: .word, scheme: .lemma)
            
            if let lemma = res.0?.rawValue {
                if !stopWords.contains(lemma.lowercased()) {
                    lemmatized.append(lemma)
                }
            }
        }
    
        let end = DispatchTime.now()
        print("🤓 a total of \(lemmatized.count) words were lemmatized in \((end.uptimeNanoseconds - start.uptimeNanoseconds)/(1000_000)) ms, and now await further processing!")
        
        return lemmatized
    }
    
    // MARK: Private
    private func loadStopWords() {
        guard let stopWordsList = readFile("stopwords", withExtension: nil)?.split(separator: "\n") else { fatalError("Cannot load stopwords!") }
        stopWordsList.map{ String($0) }.forEach { self.stopWords.insert($0) }
    }
    
    private func readFile(_ filename: String, withExtension: String? = nil) -> String? {
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: withExtension) else { return nil }
        do {
            return try String.init(contentsOf: filePath, encoding: .utf8)
        } catch {
            print("😱 Couldn't read file \(filename)! Error: \(error.localizedDescription)")
            return nil
        }
    }
}
