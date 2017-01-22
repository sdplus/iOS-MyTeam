//
//  DirectionsViewController.swift
//  MyTeam
//
//  Created by Sofie De Plus on 21/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var directions: (startAddress: String, destinationAddress: String, route: MKRoute)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    
    }

}

extension DirectionsViewController: UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "directionHeaderCell") as! DirectionHeaderCell
        header.setUp(address: directions.startAddress, distance: directions.route.distance.toString())
        
        header.accessoryType = UITableViewCellAccessoryType.none
        
        self.tableView.tableHeaderView = header
        
        return header
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}

extension DirectionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directions.route.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "directionCell", for: indexPath)
        let steps = directions.route.steps
        let step = steps[indexPath.row]

        cell.detailTextLabel?.text = step.instructions
        cell.textLabel?.text = step.distance.toString()
        cell.selectionStyle = .none
        return cell
        
        
    }
}

