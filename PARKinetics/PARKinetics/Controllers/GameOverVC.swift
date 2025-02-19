//
//  GameOverVC.swift
//  PARKinetics
//
//  Created by TANKER on 2019-10-04.
//  Copyright © 2019 TANKER. All rights reserved.
//
//  Description:
//      View controller for the game over scene, will be rendered after
//      compleation of every game
//
//  Contributors:
//      Kai Sackville-Hii
//          - File creation
//          - segues to home and back to game
//      Takunda Mwinjilo
//          - updating score
//

import Foundation
import UIKit

class GameOverVC: UIViewController {
    // MARK: Vars
    var score:Double = -1 // resulting score of the played game
    var points: Double = -1
    var count: Double = 0
    // MARK: Outlets
    @IBOutlet weak var gameScoreLabel: UILabel! // label for game score
    
    // DES: handler for calling unwind segue to home
    // PRE: unwindToHome segue exists
    // POST: render root parent view controller (home)
    @IBAction func goToHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    // MARK: Overides
    // DES: called after view appears
    // PRE: score is set from sender
    // POST: score is updated into view
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        let screenSize: CGRect = UIScreen.main.bounds
        let scaleX = screenSize.width / 768//768 is ipadPro screen width
        let scaleY = screenSize.height / 1024 //1024 is ipadPro screen height
        self.view.transform = CGAffineTransform.identity.scaledBy(x: scaleX, y: scaleY)
        points = score * 10
        let time = 0.2/points
        var _ = Timer.scheduledTimer(timeInterval: time, target: self,selector:#selector(updateScore), userInfo: nil, repeats: true)
        print(score)
    }
    @objc func updateScore(_ timer: Timer) {
        if count <= points {
            gameScoreLabel.text = "\(count)"
            if points - count < 100 {
                count += 1
            } else {
                count += 10
            }
        }
        else {
            timer.invalidate()
        }
    }
}
