//
//  Expenses+CoreDataProperties.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//
//

import Foundation
import CoreData


extension Expenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expenses> {
        return NSFetchRequest<Expenses>(entityName: "Expenses")
    }

    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var value: Float
    @NSManaged public var typeForExpense: ExpenseTypes?

}

extension Expenses : Identifiable {

}
