//
//  ExpenseTypes+CoreDataProperties.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//
//

import Foundation
import CoreData


extension ExpenseTypes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseTypes> {
        return NSFetchRequest<ExpenseTypes>(entityName: "ExpenseTypes")
    }

    @NSManaged public var name: String?
    @NSManaged public var expensesForType: NSSet?

}

// MARK: Generated accessors for expensesForType
extension ExpenseTypes {

    @objc(addExpensesForTypeObject:)
    @NSManaged public func addToExpensesForType(_ value: Expenses)

    @objc(removeExpensesForTypeObject:)
    @NSManaged public func removeFromExpensesForType(_ value: Expenses)

    @objc(addExpensesForType:)
    @NSManaged public func addToExpensesForType(_ values: NSSet)

    @objc(removeExpensesForType:)
    @NSManaged public func removeFromExpensesForType(_ values: NSSet)

}

extension ExpenseTypes : Identifiable {

}
