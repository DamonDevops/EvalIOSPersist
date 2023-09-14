//
//  AddTypeViewController.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import UIKit
import CoreData

class AddTypeViewController: UIViewController {

    @IBOutlet weak var typeTableView: UITableView!
    var typeController :NSFetchedResultsController<ExpenseTypes>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeTableView.dataSource = self
        typeTableView.delegate = self
        typeTableView.register(UINib(nibName: "AddExpenseCell", bundle: nil), forCellReuseIdentifier: "AddExpenseCell")
        
        let request = ExpenseTypes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        typeController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DataManager.shared.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        typeController.delegate = self
        
        do{
            try typeController.performFetch()
        }catch{
            print("Initial fetch error: ", error)
        }
    }
    
    @IBAction func addType(_ sender: Any) {
        let alert = UIAlertController(title: "Add Type:", message: "", preferredStyle: .alert)
        alert.addTextField{ field in
            field.autocapitalizationType = .sentences
            field.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "SAVE", style: .default){_ in
            guard let name = alert.textFields?[0].text, !name.isEmpty
            else{return}
            DataManager.shared.addType(pType: name)
            DataManager.save()
        })
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension AddTypeViewController :NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        typeTableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        typeTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch(type){
        case .insert:
            typeTableView.insertSections([sectionIndex], with: .automatic)
        case .delete:
            typeTableView.deleteSections([sectionIndex], with: .automatic)
        default:
            break
        }
    
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            typeTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            typeTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            typeTableView.deleteRows(at: [indexPath!], with: .automatic)
            typeTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            typeTableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
}

extension AddTypeViewController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeController.sections?[0].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTableView.dequeueReusableCell(withIdentifier: "AddExpenseCell", for: indexPath) as! AddExpenseCell
        cell.setupCell(pType: typeController.object(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.shared.context.delete(typeController.object(at: indexPath))
            DataManager.save()
        }
    }
}
