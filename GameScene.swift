//
//  GameScene.swift
//  kwon_Ethan_PongApp
//
//  Created by Period Three on 2020-01-13.
//  Copyright © 2020 Period Three. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    // Sets the viewController to the GameViewController
    var viewContoller: UIViewController?
    // Label for the newGame label
    var newGame = SKLabelNode()
    // Label for the player's points
    var playerPoints = SKLabelNode()
    // Label for the enemy's points
    var enemyPoints = SKLabelNode()
    // Node for the ball
    var ball = SKSpriteNode()
    // Node for the player
    var player = SKSpriteNode()
    // Node for the enemy
    var enemy = SKSpriteNode()
    // Sets timer to type Timer()
    var timer = Timer()
    // Sets time to 0
    var time: Int = 0
    // Label for the time
    var timeLabel = SKLabelNode()
    // Array for the score
    var score = [Int]()
    
    // Formats the leaderboard to make sure that the times are in order from quickest to slowest
    func leaderboardFormatter(array: [String]) -> [String] {
        // Creates a mutable array from the give array
        var mutableArray = array
        // If the array's first index is "" then remove "" and append the player's time
        if mutableArray.first == "" {
            mutableArray.append("\(playerName), Time: \(self.format(time: TimeInterval(self.time)))")
            mutableArray.remove(at: 0)
        }
        // Otherwise check each index of the array and place the player's time at the index where the index's time before is quicker than the player's time and the index's time after is slower than the player's time
        else {
            // Goes through each index of the array to get the reversed form of the time
            for (index, person) in array.enumerated() {
                var reversedTimeString: String = ""
                var timeString: String = ""
                for time in person.reversed() {
                    if time == " " {
                        break
                    } else {
                        reversedTimeString.append(time)
                    }
                }
                // Returns the value of time in proper order
                for character in reversedTimeString.reversed() {
                    timeString.append(character)
                }
                
                // Turned the string into the array
                var mutableTimeArray = Array(timeString)
                
                // Removes : from array
                mutableTimeArray.remove(at: 2)
                
                // Assigns the string value of the array without : to timeString
                timeString = String(mutableTimeArray)
                
                // Turns the player's time into an array
                var mutablePlayerArray = Array(self.format(time: TimeInterval(self.time)))
                
                // Removes : from the array
                mutablePlayerArray.remove(at: 2)
                
                // Assigns the string value of the array without : to playerTimeString
                let playerTimeString = String(mutablePlayerArray)
                
                // Checks where to put the player's time based on the time given from the for loop. Then places the time at the correct index.
                if index == 0 && Int(timeString)! >= Int(playerTimeString)! {
                    mutableArray.insert("\(playerName), Time: \(self.format(time: TimeInterval(self.time)))", at: 0)
                    break
                }
                else if Int(timeString)! >= Int(playerTimeString)! {
                    mutableArray.insert("\(playerName), Time: \(self.format(time: TimeInterval(self.time)))", at: index)
                    break
                }
                else if mutableArray[index] == mutableArray.last && Int(timeString)! <= Int(playerTimeString)! {
                    mutableArray.append("\(playerName), Time: \(self.format(time: TimeInterval(self.time)))")
                    break
                }
            }
        }
        // Return the new array with the player's time
        return(mutableArray)
    }
    
    // Starts a new game of pong and resets the score
    func startNewGame() {
        // Reset player and enemy score
        score[0] = 0
        score[1] = 0
        // Resets the labels for points to 0
        playerPoints.text = "\(score[0])"
        enemyPoints.text = "\(score[1])"
        // Set time to 0 seconds
        time = 0
        // Resets the label to the formatted form of 0 seconds
        timeLabel.text = "Time: \(format(time: TimeInterval(time)))"
        // Runs the timer function
        runTimer()
        // Resets the player's and enemy's paddle to the middle of the screen at opposite ends
        player.position = CGPoint(x: 0, y: -550)
        enemy.position = CGPoint(x: 0, y: 550)
        // Starts the game
        self.isPaused = false
        // Gives the ball a velocity of 0,0
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        // Hides the newGame label
        newGame.isHidden = true
    }
    
    // Runs at the beginning of the game to show the score at 0
    func startGame() {
        // Creates the score array
        score = [0,0]
        // Sets the label for the player's and enemy's points to 0
        playerPoints.text = "\(score[0])"
        enemyPoints.text = "\(score[1])"
    }
    
    // Runs the timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameScene.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // Object to be used in the timer
    @objc func updateTimer() {
        // Adds 1 to the time every second
        time += 1
        // Sets the time label to the formatted current time
        timeLabel.text = "Time: \(format(time: TimeInterval(time)))"
    }
    
    // Formats the time given and outputs the string of the formatted minute and seconds
    func format(time: TimeInterval) -> String {
        // Formats the time left to a minute value
        let minutes = Int(time) / 60 % 60
        // Formats the time left to a seconds value without the minute value
        let seconds = Int(time) % 60
        // Returns the string form of the formatted minute and seconds value
        return String(format: "%02i:%02i", arguments: [minutes, seconds])
    }
    
    // Checks the score of the enemy and player to see if it equals 12. If so, send an alert that congratulates the winner for beating the AI or an alert that says that you have lost. Then stop the timer and game
    func checkScore() {
        // Creates an alert with an empty title and message
        let winOrLoseAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        // Adds an action that dismisses the alert
        winOrLoseAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        // If player's score is equal to 12
        if score[0] == 12 {
            // Reveals the new game label
            newGame.isHidden = false
            // Stops the timer
            timer.invalidate()
            // Pauses the game
            self.isPaused = true
            // Sets the title of the alert to "Congratulations"
            winOrLoseAlert.title = "Congratulations"
            // Sets the message of the alert to "Congrats! You managed to beat the AI with \(score[0]) points against his \(score[1]) points in \(format(time: TimeInterval(time))) seconds."
            winOrLoseAlert.message = "Congrats! You managed to beat the AI with \(score[0]) points against his \(score[1]) points in \(format(time: TimeInterval(time))) seconds."
            // Adds an action to the alert that adds the player's time to the leaderboard
            winOrLoseAlert.addAction(UIAlertAction(title: "Add to Leaderboard", style: .default, handler: { (action:UIAlertAction) in
                // If the current game mode is easy
                if currentGameType == 1 {
                    // Runs the format leaderboard function and assigns the new array to easyLeaderboard
                    easyLeaderboard = self.leaderboardFormatter(array: easyLeaderboard)
                    // Assigns the easyLeaderboard to the User Defaults for the key easyLeaderboard
                    UserDefaults.standard.set(easyLeaderboard, forKey: "easyLeaderboard")
                    // Performs a segue with addToLeaderboard
                    self.viewContoller?.performSegue(withIdentifier: "addToLeaderboard", sender: nil)
                }
                // If the current game mode is medium
                else if currentGameType == 2 {
                    // Runs the format leaderboard function and assigns the new array to mediumLeaderboard
                    mediumLeaderboard = self.leaderboardFormatter(array: mediumLeaderboard)
                    // Assigns the mediumLeaderboard to the User Defaults for the key mediumLeaderboard
                    UserDefaults.standard.set(mediumLeaderboard, forKey: "mediumLeaderboard")
                    // Performs a segue with addToLeaderboard
                    self.viewContoller?.performSegue(withIdentifier: "addToLeaderboard", sender: nil)
                }
                // If the current game mode is hard
                else if currentGameType == 3 {
                    // Runs the format leaderboard function and assigns the new array to hardLeaderboard
                    hardLeaderboard = self.leaderboardFormatter(array: hardLeaderboard)
                    // Assigns the hardLeaderboard to the User Defaults for the key hardLeaderboard
                    UserDefaults.standard.set(hardLeaderboard, forKey: "hardLeaderboard")
                    // Performs a segue with addToLeaderboard
                    self.viewContoller?.performSegue(withIdentifier: "addToLeaderboard", sender: nil)
                }
            }))
            // Presents the alert
            view?.window?.rootViewController?.present(winOrLoseAlert, animated: true, completion: nil)
        }
        // If the enemy's score is equal to 12
        else if score[1] == 12 {
            // Reveal the new game label
            newGame.isHidden = false
            // Stops the timer
            timer.invalidate()
            // Pauses the game
            self.isPaused = true
            // Sets the title of the alert to "Lose"
            winOrLoseAlert.title = "Lose"
            // Sets the message of the alert to "You lost against the AI. He managed to get \(score[1]) points against your \(score[0]) points."
            winOrLoseAlert.message = "You lost against the AI. He managed to get \(score[1]) points against your \(score[0]) points."
            // Presents the alert
            view?.window?.rootViewController?.present(winOrLoseAlert, animated: true, completion: nil)
        }
    }
    
    // Function that adds the score to the player that scores the ball
    func addScore(playerWhoWon: SKSpriteNode) {
        // Sets the position of the ball to 0,0
        ball.position = CGPoint(x: 0, y: 0)
        // Gives the ball a velocity of 0,0
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        // A switch case that uses the value of currentGameType
        switch currentGameType {
        // If the case is easy game mode, value of 1
        case 1:
            // If the player who scored is the player
            if playerWhoWon == player {
                // Add 1 to the player's score
                score[0] += 1
                // Applys an impulse to the ball in the upper right direction with a value of 20
                ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            }
            // If the player who scored is the enemy
            else if playerWhoWon == enemy {
                // Add 1 to the enemy's score
                score[1] += 1
                // Applys an impulse to the ball in the lower left direction with a value of 20
                ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            }
        // If the case is medium game mode, value of 2
        case 2:
            // If the player who scored is the player
            if playerWhoWon == player {
                // Add 1 to the player's score
                score[0] += 1
                // Applys an impulse to the ball in the upper right direction with a value of 25
                ball.physicsBody?.applyImpulse(CGVector(dx: 25, dy: 25))
            }
            // If the player who scored is the enemy
            else if playerWhoWon == enemy {
                // Add 1 to the enemy's score
                score[1] += 1
                // Applys an impulse to the ball in the lower left direction with a value of 25
                ball.physicsBody?.applyImpulse(CGVector(dx: -25, dy: -25))
            }
        
        // If the case is hard game mode, value of 3
        case 3:
            // If the player who scored is the player
            if playerWhoWon == player {
                // Add 1 to the player's score
                score[0] += 1
                // Applys an impulse to the ball in the upper right direction with a value of 30
                ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
            }
            // If the player who scored is the enemy
            else if playerWhoWon == enemy {
                // Add 1 to the enemy's score
                score[1] += 1
                // Applys an impulse to the ball in the lower left direction with a value of 30
                ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
            }
        // Otherwise default to this value
        default:
            // If the player who scored is the player
            if playerWhoWon == player {
                // Add 1 to the player's score
                score[0] += 1
                // Applys an impulse to the ball in the upper right direction with a value of 20
                ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            }
            // If the player who scored is the enemy
            else if playerWhoWon == enemy {
                // Add 1 to the enemy's score
                score[1] += 1
                // Applys an impulse to the ball in the lower left direction with a value of 20
                ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            }
        }
        // Run the checkScore function
        checkScore()
        // Update the labels for the player's points and enemy's points to the new value of their points
        playerPoints.text = "\(score[0])"
        enemyPoints.text = "\(score[1])"
    }
    // Once the game screen appears
    override func didMove(to view: SKView) {
        // Run the startGame function
        startGame()
        // Run the runTimer function
        runTimer()
        // Set ball as the child node named "pongBall"
        ball = self.childNode(withName: "pongBall") as! SKSpriteNode
        // Set player as the child node named "player"
        player = self.childNode(withName: "player") as! SKSpriteNode
        // Set enemy as the child node named "enemy"
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        // Set playerPoints to the child node named "bottomLabel"
        playerPoints = self.childNode(withName: "bottomLabel") as! SKLabelNode
        // Set enemyPoints to the child node named "topLabel"
        enemyPoints = self.childNode(withName: "topLabel") as! SKLabelNode
        // Set timeLabel to the child node named "time"
        timeLabel = self.childNode(withName: "time") as! SKLabelNode
        // Set newGame to the child node named "newGame"
        newGame = self.childNode(withName: "newGame") as! SKLabelNode
        // Hide the newGame label
        newGame.isHidden = true
        
        // A switch case that uses the value of currentGameType
        switch currentGameType {
        // If the current game mode is easy, value of 1
        case 1:
            // Applys an impulse to the ball to the upper right direction with a value of 20
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        // If the current game mode is medium, value of 2
        case 2:
            // Applys an impulse to the ball to the upper right direction with a value of 25
            ball.physicsBody?.applyImpulse(CGVector(dx: 25, dy: 25))
        // If the current game mode is hard, value of 3
        case 3:
            // Applys an impulse to the ball to the upper right direction with a value of 30
            ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        // Otherwise run this code
        default:
            // Applys an impulse to the ball to the upper right direction with a value of 20
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        
        // Assign border to the physics body of the view's frame
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        // Set the border's friction to 0
        border.friction = 0
        // Set the border's restitution to 1
        border.restitution = 1
        // The current's view's physics body is the border
        self.physicsBody = border
    }
    
    // Whenever it detects a touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // For each touch in the touches
        for touch in touches {
            // Set the location to the current location of the touch
            let location = touch.location(in: self)
            // Move the player's paddle to the location touched for a duration of 0.2
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            // If the newGame label contains the location
            if newGame.contains(location) && newGame.isHidden == false {
                // Set the newGame label's alpha value to 0.4
                newGame.alpha = 0.4
            }
            // Otherwise
            else {
                // newGame label's alpha value equals 1
                newGame.alpha = 1
            }
        }
    }
    
    // Whenever it detects a moved touch
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // For each touch in the touches
        for touch in touches {
            // Set the location to the current location of the touch
            let location = touch.location(in: self)
            // Move the player's paddle to the location touched for a duration of 0.2
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            // If the newGame label contains the location
            if newGame.contains(location) && newGame.isHidden == false {
                // Set the newGame label's alpha value to 0.4
                newGame.alpha = 0.4
            }
            // Otherwise
            else {
                // newGame label's alpha value equals 1
                newGame.alpha = 1
            }
        }
    }
    
    // Whenever it detects a touch that is ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // For each touch in touches
        for touch in touches {
            // Set the location to the current location of the touch
            let location = touch.location(in: self)
            // If the newGame label contains the location
            if newGame.contains(location) && newGame.isHidden == false {
                // Run the startNewGame function
                startNewGame()
                // Hide the newGame label
                newGame.isHidden = true
            }
        }
    }
   
    // Runs before every frame is rendered
    override func update(_ currentTime: TimeInterval) {
        // A switch case that uses the value of currentGameType
        switch currentGameType {
        // If the currentGameType is easy mode, value of 1
        case 1:
            // The enemy moves to the ball's position for a duration of 0.2
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
        // If the currentGameType is medium mode, value of 2
        case 2:
            // The enemy moves to the ball's position for a duration of 0.15
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.15))
        // If the currentGameType if hard mode, value of 3
        case 3:
            // The enemy moves to the ball's position for a duration of 0.1
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.1))
        // Otherwise run this code
        default:
            // The enemy moves to the ball's position for a duration of 0.2
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
        }
        
        // If the ball's y position is less than or equal to the player's y position
        if ball.position.y <= player.position.y - 70 {
            // Run the addScore function with value of enemy
            addScore(playerWhoWon: enemy)
        }
        // If the ball's y position is greater than or equal to the enemy's y position
        else if ball.position.y >= enemy.position.y + 70 {
            // Run the addScore function with value of player
            addScore(playerWhoWon: player)
        }
    }
}
