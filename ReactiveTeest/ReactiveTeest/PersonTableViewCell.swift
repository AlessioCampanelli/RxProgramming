//
//  PersonTableViewCell.swift
//  ReactiveTeest
//
//  Created by Alessio Campanelli on 07/12/2018.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
