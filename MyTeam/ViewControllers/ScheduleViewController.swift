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
    // fileprivate var model = GameModel()
    
    fileprivate var games: [Game] = []
    private var currentTask: URLSessionTask?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up UISplitViewController delegate to enable collapsing.
        splitViewController!.delegate = self
        splitViewController!.preferredDisplayMode = .allVisible
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentTask = Service.shared.loadDataTask {
            result in
            switch result {
            case .success(let games):
                self.games = games.sorted { $0.date < $1.date }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                self.tableView.reloadData() // to hide separators
            }
            // activityIndicator.stopAnimating()
        }
        currentTask!.resume()
        
        // Set up refresh control.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl

    }
    
    func refreshTableView() {
        currentTask?.cancel()
        currentTask = Service.shared.loadDataTask {
            result in
            switch result {
            case .success(let games):
                self.games = games.sorted { $0.date < $1.date }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
        
                self.tableView.reloadData() // to hide separators
            }
            self.tableView.refreshControl!.endRefreshing()
        }
        currentTask!.resume()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let gameViewController = navigationController.topViewController as! GameViewController
        let selectedIndex = tableView.indexPathForSelectedRow!.row
        gameViewController.game = games[selectedIndex]
    }
    
    
    
}

extension ScheduleViewController: UITableViewDelegate {
    
}

extension ScheduleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        let game = games[indexPath.row]
        cell.homeTeamNameLabel.text = "\(game.homeTeam)"
        cell.awayTeamNameLabel.text = game.awayTeam
        cell.timeLabel.text = game.time
        cell.dateLabel.text = game.date.toString() // format date

        return cell
        

    }
}


extension ScheduleViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // Show master view controller first on iPhone
        // master view controller always collapse onto the detail view controller
        return true
    }
}
