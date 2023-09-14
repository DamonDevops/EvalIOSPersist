//
//  ExpensesManager.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import Foundation

extension DataManager{
    
    func addExpense(_name :String, _date :Date, _value :Float, _type :ExpenseTypes){
        let expense = Expenses(context: context)
        expense.name = _name
        expense.date = _date
        expense.value = _value
        expense.typeForExpense = _type
        
        DataManager.save()
    }
    
    func getExpenses() -> [Expenses]?{
        let request = Expenses.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return DataManager.fetch(request: request)
    }
}
