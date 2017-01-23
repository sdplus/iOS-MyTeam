//
//  GameModel.swift
//  MyTeam
//
//  Created by Sofie De Plus on 18/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//
import CoreLocation

class GameModel {
    
    var games: [Game] = [
        Game(league: "1ste nationale", gameday: 16, homeTeam:"KAA Gent", awayTeam: "Zulte-Waregem", location: CLLocationCoordinate2DMake(58, 52),street: "Botestraat", no: 98, city: "Gent", zip: 9000, date: Date(), time: "14:30", homeTeamScore: 3, awayTeamScore: 1),
        Game(league: "1ste nationale", gameday: 19, homeTeam:"Dames Eendracht Aalst", awayTeam: "KAA Gent", location: CLLocationCoordinate2DMake(58, 52), street: "Zandberg", no: 3, city: "Aalst", zip: 9300, date: Date(), time: "15:00", homeTeamScore: -1, awayTeamScore: -1)
    ]
    
    func game(at index: Int) -> Game {
        guard index >= 0 && index < games.count else {
            fatalError("Invalid index into GameModel: \(index)")
        }
        return games[index]
    }
    
}
