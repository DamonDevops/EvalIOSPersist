//
//  ExpenseTypesManager.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import Foundation

extension DataManager{
    
    func addTypes(pArray :[String]){
        pArray.forEach{ type in
            let expenseType = ExpenseTypes(context: context)
            expenseType.name = type
            DataManager.save()
        }
    }
    
    func addType(pType :String){
        let type = ExpenseTypes(context: context)
        type.name = pType
        DataManager.save()
    }
    
    func getAllTypes() -> [ExpenseTypes]?{
        let request = ExpenseTypes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return DataManager.fetch(request: request)
    }
    func getType(type :String) -> ExpenseTypes?{
        let request = ExpenseTypes.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", type)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return DataManager.fetch(request: request)?.first
    }
}
