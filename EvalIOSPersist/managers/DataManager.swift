//
//  DataManager.swift
//  EvalIOSPersist
//
//  Created by Student04 on 13/09/2023.
//

import Foundation
import CoreData

class DataManager{
    static let shared = DataManager()
    let context :NSManagedObjectContext
    
    init() {
        context = DataManager.getContext()
    }
    
    private static func getContext() -> NSManagedObjectContext{
        let container = NSPersistentContainer(name: "EvalIOSPersist")
        var dbFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        dbFileURL.append(path: "evalDB.sqlite")
        let storeDescription = NSPersistentStoreDescription(url: dbFileURL)
        storeDescription.type = NSSQLiteStoreType
        
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores{ desc , error in
            if let error = error{
                print("Error db storage: ", error)
            }
        }
        
        return container.viewContext
    }
    
    static func save(){
        do{
            try shared.context.save()
        }catch{
            print("Saving error : ", error)
            shared.context.rollback()
        }
    }
    static func fetch<T>(request :NSFetchRequest<T>) -> [T]?{
        do{
            let response = try shared.context.fetch(request)
            return response
        }catch{
            print("fetch error: ", error)
            return nil
        }
    }
    
    //MARK: - Expenses
    
    func addExpenses(pExpense :Expenses){
        
    }
}
