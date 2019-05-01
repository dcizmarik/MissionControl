//
//  SplashScreenViewController.swift
//  MissionControl
//
//  Created by Daniel Cizmarik on 4/28/19.
//  Copyright © 2019 Daniel Cizmarik. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var rocketImage: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(soundName: "rocketsound", audioPlayer: &audioPlayer)

        
        rocketImage.frame.origin.y = view.frame.height
        
        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        print("hello")
        UIView.animate(withDuration: 2.0, delay: 0.25, animations: {self.rocketImage.frame.origin.y = 318}) { (finished) in
                self.audioPlayer.stop()
                self.performSegue(withIdentifier: "ShowTableView", sender: nil)
            
        }
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Play a sound
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: Data in \(soundName) couldn't be played as a sound properly.")
            }
            
        } else {
            print("Error: File \(soundName) didn't load properly.")
        }
    }
    
    
}
