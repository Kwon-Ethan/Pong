//
//  MainViewController.swift
//  kwon_Ethan_PongApp
//
//  Created by Period Three on 2020-01-14.
//  Copyright © 2020 Period Three. All rights reserved.
//

import UIKit

// Variable to be used to check which game mode was clicked
public var currentGameType = 1
// Leaderboard for easy mode
public var easyLeaderboard: [String] = []
// Leaderboard for medium mode
public var mediumLeaderboard: [String] = []
// Leaderboard for hard mode
public var hardLeaderboard: [String] = []
// String for the player's name
public var playerName: String = ""

class MainViewController: UIViewController {
    // Executes when view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assigns easyLeaderboard to the saved array for easyLeaderboard if there is one. Otherwise empty array with "".
        easyLeaderboard = UserDefaults.standard.stringArray(forKey: "easyLeaderboard") ?? [""]
        // Assigns mediumLeaderboard to the saved array for mediumLeaderboard if there is one. Otherwise empty array with "".
        mediumLeaderboard = UserDefaults.standard.stringArray(forKey: "mediumLeaderboard") ?? [""]
        // Assigns hardLeaderboard to the saved array for hardLeaderboard if there is one. Otherwise empty array with "".
        hardLeaderboard = UserDefaults.standard.stringArray(forKey: "hardLeaderboard") ?? [""]
    }

    @IBOutlet var easyMode: UIButton!
    @IBOutlet var mediumMode: UIButton!
    @IBOutlet var hardMode: UIButton!
    
    // Function that checks which button sent the performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks if the sender is a UIButton and assigns it to sender
        guard let sender = sender as? UIButton else {return}
        // If sender is easyMode, assign currentGameType to 1
        if sender == easyMode {
            currentGameType = 1
        }
        // If sender is mediumMode, assign currentGameType to 2
        else if sender == mediumMode {
            currentGameType = 2
        }
        // If sender is hardMode, assign currentGameType to 3
        else if sender == hardMode {
            currentGameType = 3
        }
    }
    
    @IBAction func modePressed(_ sender: UIButton) {
        // Create an alert that says to input your name
        let introAlert = UIAlertController(title: "Input Name", message: "Please input your name.", preferredStyle: .alert)
        // Adds a textfield to the alert that will take the player's name
        introAlert.addTextField(configurationHandler: {
            (textfield:UITextField) in
                textfield.placeholder = "Player Name"
            })
        // Adds an action to the alert that dismisses the alert
        introAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        // Adds an action to the alert that goes to the game screen if a name has been inputted.
        introAlert.addAction((UIAlertAction(title: "Go to Game", style: .default, handler: { _ in
            if introAlert.textFields![0].text?.isEmpty == true {
                // If a name has not been inputted, send a second alert that says there is an error and to input a name.
                let errorAlert = UIAlertController(title: "Error", message: "Please input a name", preferredStyle: .alert)
                // Add an action to error alert that sends the introAlert again.
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                    _ in
                    self.present(introAlert, animated: true, completion: nil)
                }))
                // Present the errorAlert
                self.present(errorAlert, animated: true, completion: nil)
            }
            // If the textfield has text inside, assign the string to playerName. Then perform a segue with "goToGame" with a sender of sender
            else if introAlert.textFields![0].text?.isEmpty == false {
                playerName = introAlert.textFields![0].text ?? "Player"
                self.performSegue(withIdentifier: "goToGame", sender: sender)
            }
        })))
        // Present the introAlert
        self.present(introAlert, animated: true, completion: nil)
    }
    
    @IBAction func helpPressed(_ sender: UIButton) {
        // Performs a segue with "goToHelp" which sends the user to the help page
        performSegue(withIdentifier: "goToHelp", sender: sender)
    }
    @IBAction func leaderboardPressed(_ sender: UIButton) {
        // Performs a segue with "goToLeaderboard" which sends the user to the leaderboard page
        performSegue(withIdentifier: "goToLeaderboard", sender: sender)
    }
    
}
