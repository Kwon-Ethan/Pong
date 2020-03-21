//
//  GameViewController.swift
//  kwon_Ethan_PongApp
//
//  Created by Period Three on 2020-01-13.
//  Copyright © 2020 Period Three. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                let currentScene = scene as! GameScene
                currentScene.viewContoller = self
                // Present the scene
                view.presentScene(scene)
            }
            // Ignores the order of the other child nodes
            view.ignoresSiblingOrder = true
            
            // Shows the frames per second
            view.showsFPS = true
            // Shows the node count
            view.showsNodeCount = false
        }
    }
    
    // Does not autorotate the view to fit the phone's rotation
    override var shouldAutorotate: Bool {
        return false
    }

    // All orientations except for upside down
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    // Hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
