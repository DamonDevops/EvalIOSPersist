//
//  AddTypeViewController.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import UIKit

class AddTypeViewController: UIViewController {

    @IBOutlet weak var typeTableView: UITableView!
    var typeList :[ExpenseTypes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let check = DataManager.shared.getAllTypes(){
            typeList = check
        }
        
        typeTableView.dataSource = self
        typeTableView.delegate = self
        typeTableView.register(UINib(nibName: "AddExpenseCell", bundle: nil), forCellReuseIdentifier: "AddExpenseCell")
    }
    
    @IBAction func addType(_ sender: Any) {
        let alert = UIAlertController(title: "Add Type:", message: "", preferredStyle: .alert)
        alert.addTextField{ field in
            field.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "SAVE", style: .default){_ in
            guard let name = alert.textFields?[0].text, !name.isEmpty
            else{return}
            DataManager.shared.addType(pType: name)
            DataManager.save()
            if let newItem = DataManager.shared.getType(type: name){
                self.typeList.append(newItem)
            }
            self.typeTableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension AddTypeViewController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTableView.dequeueReusableCell(withIdentifier: "AddExpenseCell", for: indexPath) as! AddExpenseCell
        cell.setupCell(pType: typeList[indexPath.row])
        return cell
    }
}
