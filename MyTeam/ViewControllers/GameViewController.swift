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
            cell.homeTeamNameLabel.text = game.homeTeam
            cell.awayTeamNameLabel.text = game.awayTeam
            cell.dateLabel.text = game.date.toString()
            cell.timeLabel.text = (game.homeTeamScore != -1 && game.awayTeamScore != -1) ? "\(game.homeTeamScore) - \(game.awayTeamScore)" : game.time
            cell.leagueNameType.text = game.league
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressCell
            cell.streetNrLabel!.text = "\(game.street) \(game.no)"
            cell.zipCityLabel!.text = "\(game.zip) \(game.city)"
            cell.updateUI()
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "squadCell", for: indexPath) as! SquadCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
