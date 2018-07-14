//
//  FlashCard+CoreDataProperties.swift
//  Flashcard App
//
//  Created by Shivang Ranjan on 02/07/18.
//  Copyright © 2018 Shivang Ranjan. All rights reserved.
//
//

import Foundation
import CoreData


extension FlashCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?

}
