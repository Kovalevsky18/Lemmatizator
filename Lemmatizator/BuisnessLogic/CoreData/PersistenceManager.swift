//
//  PersistenceManager.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/18/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    static let shared = PersistenceManager()
    init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Lemmatizator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    let privateChildContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    // MARK: - Core Data Saving support
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("safe successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveBook(title: String, minWord: String, maxWord: String, medianWord: String, word: [(String,Int)]) {
        privateChildContext.parent = context
        
        if !checkBook(title: title) {
            privateChildContext.performAndWait {
                let book = Book(context: PersistenceManager.shared.context)
                book.title = title
                book.minWord = minWord
                book.maxWord = maxWord
                book.medianWord = medianWord
                for element in word {
                    let word = Word(context: PersistenceManager.shared.context)
                    word.definition = String(element.1)
                    word.wordName = element.0
                    word.book = book
                    book.addToWord(word)
                }
            }
            privateChildContext.performAndWait {
                try! privateChildContext.save()
            }
        }
        else {
            print("Error , book was uploaded earlier")
        }
    }
    
    func getBooks() -> [Book]? {
        guard let book = try! context.fetch(Book.fetchRequest()) as? [Book] else {return nil}
        return book
    }
    
    func dataLoaded(completion: @escaping ([Book]?) -> Void) {
        if getBooks() != nil {
            completion(getBooks())
        }
    }
    
    func getWords() -> [Word]? {
        if let data = getBooks()?.first?.word?.allObjects as? [Word] { return data }
        return nil
    }
    
    func deleteAllitems() {
        guard let book = try! context.fetch(Book.fetchRequest()) as? [Book] else {return }
        
        for element in book {
            context.delete(element)
        }
        
        try! context.save()
        
    }
    
    func checkBook(title: String) -> Bool {
        guard let book = try! context.fetch(Book.fetchRequest()) as? [Book] else {return false}
        
        for element in book {
            if element.title == title {
                return true
            }
        }
        return false
    }
    
}
