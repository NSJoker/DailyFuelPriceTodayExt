//
//  DFPCitiesCell.swift
//  DailyFuelPrice
//
//  Created by Chandrachudh on 05/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class DFPCitiesCell: UITableViewCell {

    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSelected: UILabel!
    
    class func reuseIdentifier()->String {
        return "DFPCitiesCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareView() {
        lblSelected.layer.cornerRadius = 4.0
        lblSelected.layer.borderColor = lblSelected.textColor.cgColor
        lblSelected.layer.borderWidth = 1.0
    }
    
}
