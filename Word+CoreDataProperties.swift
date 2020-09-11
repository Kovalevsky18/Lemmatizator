//
//  Word+CoreDataProperties.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/19/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var definition: String?
    @NSManaged public var wordName: String?
    @NSManaged public var book: Book?

}
