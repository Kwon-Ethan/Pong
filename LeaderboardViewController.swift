//
//  LeaderboardViewController.swift
//  kwon_Ethan_PongApp
//
//  Created by Period Three on 2020-01-15.
//  Copyright © 2020 Period Three. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Returns the number of rows to build
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the selected index of the switch is 0, return the counted value of the easyLeaderboard
        if leaderboardSwitch.selectedSegmentIndex == 0 {
            return(easyLeaderboard.count)
        }
        // If the selected index of the switch is 1, return the counted value of the mediumLeaderboard
        else if leaderboardSwitch.selectedSegmentIndex == 1 {
            return(mediumLeaderboard.count)
        }
        // If the selected index of the switch is 2, return the counted value of the hardLeaderboard
        else if leaderboardSwitch.selectedSegmentIndex == 2 {
            return(hardLeaderboard.count)
        }
        // Otherwise, return 1
        else {
            return(1)
        }
    }
    
    //Puts the text inside of each cell in the order of the array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Assigns cell to the table view cell type
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        // If the selected index of the switch is 0, set the cell's label text to the string from easyLeaderboard of that row
        if leaderboardSwitch.selectedSegmentIndex == 0 {
            cell.textLabel?.text = easyLeaderboard[indexPath.row]
        }
        // If the selected index of the switch is 1, set the cell's label text to the string from mediumLeaderboard of that row
        else if leaderboardSwitch.selectedSegmentIndex == 1 {
            cell.textLabel?.text = mediumLeaderboard[indexPath.row]
        }
        // If the selected index of the switch is 2, set the cell's label text to the string from hardLeaderboard of that row
        else if leaderboardSwitch.selectedSegmentIndex == 2 {
            cell.textLabel?.text = hardLeaderboard[indexPath.row]
        }
        // Return the cell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func leaderboardSwitchPressed(_ sender: UISegmentedControl) {
        // Reload the data of the leaderboard when the switch is pressed
        leaderboard.reloadData()
    }
    
    @IBOutlet var leaderboardSwitch: UISegmentedControl!
    
    @IBOutlet var leaderboard: UITableView!
}
