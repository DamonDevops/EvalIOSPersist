//
//  AddExpenseViewController.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import UIKit

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var valueField: UITextField!
    var typeList :[ExpenseTypes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideonTap()
        if let check = DataManager.shared.getAllTypes(){
            typeList = check
        }
        
        typeTableView.dataSource = self
        typeTableView.delegate = self
        typeTableView.register(UINib(nibName: "AddExpenseCell", bundle: nil), forCellReuseIdentifier: "AddExpenseCell")
    }
    
    @IBAction func saveExpense(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty,
              let valueText = valueField.text, !valueText.isEmpty,
              let typeID = typeTableView.indexPathForSelectedRow
        else{
            let alert = UIAlertController(title: "An error has occured", message: "One ore more fields are empty or incorrectly filled, please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        guard let value = Float(valueText) else { return }
        
        DataManager.shared.addExpense(_name: name, _date: datePicker.date, _value: value, _type: typeList[typeID.row])
        DataManager.save()
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension AddExpenseViewController :UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTableView.dequeueReusableCell(withIdentifier: "AddExpenseCell", for: indexPath) as! AddExpenseCell
        cell.setupCell(pType: typeList[indexPath.row])
        return cell
    }
    
    
}
