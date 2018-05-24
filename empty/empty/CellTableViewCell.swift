//
//  CellTableViewCell.swift
//  empty
//
//  Created by Krystian Kulawiak on 24/05/2018.
//  Copyright © 2018 Krystian Kulawiak. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.2
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.baselineAdjustment = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}
