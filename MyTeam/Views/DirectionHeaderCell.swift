//
//  DirectionHeaderCell.swift
//  MyTeam
//
//  Created by Sofie De Plus on 22/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class DirectionHeaderCell: UITableViewCell {

    
    @IBOutlet weak var starterPin: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setUp(address: String, distance: String){
        addressLabel.text = address
        distanceLabel.text = distance
    }
}
