//
//  GameViewController.swift
//  MyTeam
//
//  Created by Sofie De Plus on 19/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!


    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)

    }
    


    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if !splitViewController!.isCollapsed {
            navigationItem.leftBarButtonItem = splitViewController!.displayModeButtonItem
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapViewController
        destination.destinationLocation = game.location
        destination.destinationAddress = "\(game.street) \(game.no), \(game.city)"
    }



}

extension GameViewController: UITableViewDelegate {
    
    
}

extension GameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
            cell.game = game
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressCell
            cell.game = game
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "squadCell", for: indexPath) as! SquadCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    
    
}
