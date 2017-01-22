//
//  GameView.swift
//  MyTeam
//
//  Created by Sofie De Plus on 22/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class GameView: UIViewController {


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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapViewController
        destination.destinationLocation = game.location
        destination.destinationAddress = "\(game.street) \(game.no), \(game.city)"
    }
    
    
    
}

extension GameView: UICollectionViewDelegate {
    
    
}

extension GameView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("show cells")
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCollectionCell
            cell.homeTeamLabel!.text = game.homeTeam
            /*cell.awayTeamNameLabel!.text = game.awayTeam
            cell.scoreLabel!.text = "\(game.homeTeamScore) - \(game.awayTeamScore)"*/
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addressCell", for: indexPath) as! AddressCell
            cell.streetNrLabel!.text = "\(game.street) \(game.no)"
            cell.zipCityLabel!.text = "\(game.zip) \(game.city)"
            print("make address cell")
            cell.updateUI()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squadCell", for: indexPath) as! SquadCell
            return cell
            
        }
        
        
        
    }
    
}

extension GameView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: collectionView.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

