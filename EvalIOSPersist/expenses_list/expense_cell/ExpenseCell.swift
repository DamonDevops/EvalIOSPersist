//
//  ExpenseCell.swift
//  EvalIOSPersist
//
//  Created by Student04 on 14/09/2023.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(pExpense :Expenses){
        nameLabel.text = pExpense.name
        let str = "\(pExpense.value) €"
        valueLabel.text = str
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        dateLabel.text = formatter.string(from: pExpense.date)
    }
    
}
