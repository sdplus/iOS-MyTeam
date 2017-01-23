//
//  DirectionFooterCell.swift
//  MyTeam
//
//  Created by Sofie De Plus on 22/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class DirectionFooterCell: UITableViewCell {
    
    
    @IBOutlet weak var destinationPin: UIImageView!
    @IBOutlet weak var destinationAddressLabel: UILabel!
    
    var destinationAddress: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
        if let destinationAddress = self.destinationAddress {
            destinationAddressLabel.text = destinationAddress

        }
    }
}
