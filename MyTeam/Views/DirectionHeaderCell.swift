//
//  DirectionHeaderCell.swift
//  MyTeam
//
//  Created by Sofie De Plus on 22/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit
import MapKit

class DirectionHeaderCell: UITableViewCell {

    
    @IBOutlet weak var starterPin: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var directions: (startAddress: String, destinationAddress: String, route: MKRoute)? {
        didSet {
            updateUI()
        }
    }

    
    private func updateUI(){
        
        if let directions = self.directions {
            addressLabel.text = directions.startAddress
            distanceLabel.text = directions.route.distance.toString()
        }
        
        self.accessoryType = UITableViewCellAccessoryType.none
        
    }
}
