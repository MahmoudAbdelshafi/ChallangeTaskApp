//
//  CurrencyTableViewCell.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var currencyPrice: UILabel!
    
    func configure(currencyName: String, currencyValue: Double){
        self.currencyLabel.text = currencyName
        self.currencyPrice.text = String(currencyValue)
    }

}
