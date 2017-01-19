//
//  ScheduleViewController.swift
//  MyTeam
//
//  Created by Sofie De Plus on 18/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//
import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var model = GameModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up UISplitViewController delegate to enable collapsing.
        splitViewController!.delegate = self
        splitViewController!.preferredDisplayMode = .allVisible
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let gameViewController = navigationController.topViewController as! GameViewController
        let selectedIndex = tableView.indexPathForSelectedRow!.row
        gameViewController.game = model.game(at: selectedIndex)
    }
    
    
}

extension ScheduleViewController: UITableViewDelegate {
    
}

extension ScheduleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        let game = model.games[indexPath.row]
        cell.homeTeamNameLabel.text = "\(game.homeTeam)"
        cell.awayTeamNameLabel.text = game.awayTeam
        cell.timeLabel.text = game.time
        cell.dateLabel.text = game.date.toString() // format date

        return cell
        

    }
}


extension ScheduleViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        print(splitViewController.traitCollection)
        print(secondaryViewController.traitCollection)
        // Show master view controller first on iPhone
        // master view controller always collapse onto the detail view controller
        return true
    }
}
