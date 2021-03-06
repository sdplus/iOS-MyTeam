//
//  Game.swift
//  MyTeam
//
//  Created by Sofie De Plus on 18/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import CoreLocation

class Game {
    
    let league: String
    let gameday: Int
    let homeTeam: String
    let awayTeam: String
    let location: CLLocationCoordinate2D
    let street: String
    let no: Int
    let city: String
    let zip: Int
    let date: Date
    let time: String
    let homeTeamScore: Int
    let awayTeamScore: Int
    
    init(league:String, gameday: Int, homeTeam: String, awayTeam: String, location: CLLocationCoordinate2D, street: String, no: Int, city: String, zip: Int, date: Date, time: String, homeTeamScore: Int, awayTeamScore: Int) {
        self.league = league
        self.gameday = gameday
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.location = location
        self.street = street
        self.no = no
        self.zip = zip
        self.city = city
        self.date = date
        self.time = time
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
    }
}


extension Game {
    
    convenience init(json: [String: Any]) throws {
        guard let league = json["league"] as? String else {
            throw Service.Error.missingJsonProperty(name: "league")
        }
        guard let gameday = json["gameday"] as? Int else {
            throw Service.Error.missingJsonProperty(name: "gameday")
        }
        guard let hTeam = json["homeTeam"] as? [String: Any] else {
            throw Service.Error.missingJsonProperty(name: "homeTeam")
        }
        guard let homeTeam = hTeam["name"] as? String else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.name")
        }
        guard let street = hTeam["street"] as? String else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.street")
        }
        guard let no = hTeam["no"] as? Int else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.no")
        }
        guard let city = hTeam["city"] as? String else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.city")
        }
        guard let zip = hTeam["zip"] as? Int else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.zip")
        }
        guard let latitude = hTeam["latitude"] as? Double else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.latitude")
        }
        guard let longitude = hTeam["longitude"] as? Double else {
            throw Service.Error.missingJsonProperty(name: "homeTeam.longitude")
        }

        guard let aTeam = json["awayTeam"] as? [String: Any] else {
            throw Service.Error.missingJsonProperty(name: "awayTeam")
        }
        guard let awayTeam = aTeam["name"] as? String else {
            throw Service.Error.missingJsonProperty(name: "awayTeam.name")
        }
        
        guard let datum = json["date"] as? String else {
            throw Service.Error.missingJsonProperty(name: "date")
        }
        guard let time = json["time"] as? String else {
            throw Service.Error.missingJsonProperty(name: "time")
        }
        guard let homeTeamScore = json["homeScore"] as? Int else {
            throw Service.Error.missingJsonProperty(name: "homeScore")
        }
        guard let awayTeamScore = json["awayScore"] as? Int else {
            throw Service.Error.missingJsonProperty(name: "awayScore")
        }
        self.init(league: league,
                  gameday: gameday,
                  homeTeam: homeTeam,
                  awayTeam: awayTeam,
                  location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                  street: street,
                  no: no,
                  city: city,
                  zip: zip,
                  date: datum.toDate(),
                  time: time,
                  homeTeamScore: homeTeamScore,
                  awayTeamScore: awayTeamScore
        )
    }
    
}
