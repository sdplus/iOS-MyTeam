//
//  AddressCell.swift
//  MyTeam
//
//  Created by Sofie De Plus on 20/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    
    
    @IBOutlet weak var streetNrLabel: UILabel!
    @IBOutlet weak var zipCityLabel: UILabel!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var backgroundCardView: UIView!
    
    func updateUI(){
        backgroundCardView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
    }
}
