//
//  GameTableViewCell.swift
//  MyTeam
//
//  Created by Sofie De Plus on 19/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueNameType: UILabel!
    
    var game: Game? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
        
        if let game = self.game {
            homeTeamNameLabel.text = game.homeTeam
            awayTeamNameLabel.text = game.awayTeam
            dateLabel.text = game.date.toString()
            timeLabel.text = (game.homeTeamScore != -1 && game.awayTeamScore != -1) ? "\(game.homeTeamScore) - \(game.awayTeamScore)" : game.time
            leagueNameType.text = game.league
        }

        self.selectionStyle = .none

    }
    
    
}
