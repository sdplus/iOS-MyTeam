//
//  GameViewController.swift
//  MyTeam
//
//  Created by Sofie De Plus on 19/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!


    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    


    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if !splitViewController!.isCollapsed {
            navigationItem.leftBarButtonItem = splitViewController!.displayModeButtonItem
        }
    }
    
    func getDirections(sender: UIButton) {
        /*
        let colorName = sender.title(for: .disabled)!
        selectedColor = model.scores.keys.filter { $0.name == colorName }.first!
        performSegue(withIdentifier: "vote", sender: sender)
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapViewController
        destination.destinationLocation = game.location
        destination.destinationAddress = "\(game.street) \(game.no), \(game.city)"
    }



}

extension GameViewController: UICollectionViewDelegate {
    
    
}

extension GameViewController: UICollectionViewDataSource {
    
   func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCollectionCell
                cell.homeTeamNameLabel!.text = game.homeTeam
                cell.awayTeamNameLabel!.text = game.awayTeam
                cell.scoreLabel!.text = "\(game.homeTeamScore) - \(game.awayTeamScore)"
                return cell

            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addressCell", for: indexPath) as! AddressCell
                cell.straatNrLabel!.text = "\(game.street) \(game.no)"
                cell.zipCityLabel!.text = "\(game.zip) \(game.city)"
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squadCell", for: indexPath) as! SquadCell
                return cell
            
        }
        
        
        
    }
    
}
