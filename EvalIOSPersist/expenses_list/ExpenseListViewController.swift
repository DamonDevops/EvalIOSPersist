//
//  ExpenseListViewController.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import UIKit
import CoreData

class ExpenseListViewController: UIViewController {

    @IBOutlet weak var expenseTable: UITableView!
    var expenseController :NSFetchedResultsController<Expenses>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let type = DataManager.fetch(request: ExpenseTypes.fetchRequest()), type.count == 0{
            DataManager.shared.addTypes(pArray: ["Necessities","Alimentation","Fraud","Debts","Taxes"])
        }
        if let expense = DataManager.fetch(request: Expenses.fetchRequest()), expense.count == 0{
            if let typeCheck = DataManager.shared.getType(type: "Fraud"){
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let date = formatter.date(from: "14/09/2023")
                DataManager.shared.addExpense(_name: "Getting a Good Evaluation Score", _date: date!, _value: 23000.0, _type: typeCheck)
            }
        }
        
        expenseTable.dataSource = self
        expenseTable.delegate = self
        expenseTable.register(UINib(nibName: "ExpenseCell", bundle: nil), forCellReuseIdentifier: "ExpenseCell")
        
        let request = Expenses.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "typeForExpense.name", ascending: true),
        NSSortDescriptor(key: "date", ascending: false)]
        expenseController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DataManager.shared.context,
            sectionNameKeyPath: "typeForExpense.name",
            cacheName: nil
        )
        expenseController.delegate = self
        
        do{
            try expenseController.performFetch()
        }catch{
            print("Initial fetch error: ", error)
        }
    }
    @IBAction func addExpense(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "addExpense")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ExpenseListViewController :NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        expenseTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        expenseTable.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch(type){
        case .insert:
            expenseTable.insertSections([sectionIndex], with: .automatic)
        case .delete:
            expenseTable.deleteSections([sectionIndex], with: .automatic)
        default:
            break
        }
    
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            expenseTable.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            expenseTable.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            expenseTable.deleteRows(at: [indexPath!], with: .automatic)
            expenseTable.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            expenseTable.reloadRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
}

extension ExpenseListViewController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseController.sections?[section].numberOfObjects ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expenseTable.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseCell
        cell.setupCell(pExpense: expenseController.object(at: indexPath))
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return expenseController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return expenseController.sections?[section].name
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.shared.context.delete(expenseController.object(at: indexPath))
            DataManager.save()
        }
    }
}
