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
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
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


}

extension GameViewController: UICollectionViewDelegate {
    
    
}

extension GameViewController: UICollectionViewDataSource {
    
   func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCollectionCell
        
        cell.homeTeamNameLabel!.text = game.homeTeam
        cell.awayTeamNameLabel!.text = game.awayTeam
        
        return cell
    }
    
}
