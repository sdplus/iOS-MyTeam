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
    
    func setUp(destinationAddress: String){
        destinationAddressLabel.text = destinationAddress
    }
}
