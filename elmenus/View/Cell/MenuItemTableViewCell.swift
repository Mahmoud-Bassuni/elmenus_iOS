//
//  MenuItemTableViewCell.swift
//  elmenus
//
//  Created by Bassuni on 6/21/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var itemNmeLbl: UILabel!
    @IBOutlet var itemDescriptionLbl: UILabel!
    func bindCell(_ _name : String ,_ _Description : String)
    {
        itemNmeLbl.text = _name
        itemDescriptionLbl.text = _Description
    }

}


