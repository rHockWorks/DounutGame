//
//  MainMenu.swift
//  Doughnut Game
//
//  Created by rHockWorks on 15/08/2019.
//  Copyright © 2019 rHockWorks. All rights reserved.
//
// THIS CODE IS MOSTLY FROM SAGNOR "ALEX" NAGY FROM REBELOPER.COM
// I HAVE SLIGHTLY MODIFIED THE CODE AS I WENT ALONG THE YOUTUBE TUTORIAL : https://www.youtube.com/watch?v=yWB5Md7PHwU&t=21s
// I HOPE YOU ENJOY THE CHANGES


import UIKit
import SpriteKit
import GameplayKit
import AVFoundation


let stopBackgroundMusicVolumeNotificationName = Notification.Name("stopBackgroundMusicVolumeNotificationName")
let startBackgroundMusicVolumeNotificationName = Notification.Name("startBackgroundMusicVolumeNotificationName")
let startGameplayNotificationName = Notification.Name("startGameplayNotificationName")
let setMusicVolumeNotificationName = Notification.Name("setMusicVolumeNotificationName")



class GameViewController: UIViewController {
    
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backgroundMusic: AVAudioPlayer? = {
        //guard let url = Bundle.main.url(forResource: HelperStrings.backgroundMusic.rawValue, withExtension: HelperStrings.m4aExtension.rawValue) else {
        guard let url = Bundle.main.url(forResource: HelperStrings.backgroundMusic.rawValue, withExtension: HelperStrings.mp3Extension.rawValue) else {
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            return player
        } catch {
            return nil
        }
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
        
        //SKVIEW BOUNDARIES/CONSTRAINTS
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        let scene = MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsNodeCount = true
        
        addNotificationObservers()
        playOrStopBackgroundMusic()
    }
    
    
    //OBSERVE NOTIFICATION LAUNCHED
    func addNotificationObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopBackgroundMusic(_:)), name: stopBackgroundMusicVolumeNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.startBackgroundMusic(_:)), name: startBackgroundMusicVolumeNotificationName, object: nil)
    }
    
    func playOrStopBackgroundMusic() {
        backgroundMusic?.play()
    }
 

    @objc func stopBackgroundMusic(_ info: Notification) {      //OBJECTIVE-C TO GET SELECTOR FROM NOTIFICATION
        
        if Stats.shared.getSound() {
            backgroundMusic?.stop()
        }
    }

    @objc func startBackgroundMusic(_ info: Notification) {
        
        if Stats.shared.getSound() {
            backgroundMusic?.play()
        }
    }


}



