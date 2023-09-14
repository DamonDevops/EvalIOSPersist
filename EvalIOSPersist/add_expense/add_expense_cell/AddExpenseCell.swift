//
//  AddExpenseCell.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import UIKit

class AddExpenseCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(pType :ExpenseTypes){
        typeLabel.text = pType.name
    }
}
