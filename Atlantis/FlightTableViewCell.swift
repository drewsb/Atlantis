//
//  FlightTableViewCell.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/26/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation
import UIKit

class FlightTableViewCell : UITableViewCell {
    
    @IBOutlet var durationLabel: UILabel!
    
    @IBOutlet var carrierLabel: UILabel!

    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var learnMoreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.layer.cornerRadius = 10
        priceLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
