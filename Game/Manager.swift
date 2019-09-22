//
//  MainMenu.swift
//  Doughnut Game
//
//  Created by rHockWorks on 11/08/2019.
//  Copyright © 2019 rHockWorks. All rights reserved.
//
// THIS CODE IS MOSTLY FROM SAGNOR "ALEX" NAGY FROM REBELOPER.COM
// I HAVE SLIGHTLY MODIFIED THE CODE AS I WENT ALONG THE YOUTUBE TUTORIAL : https://www.youtube.com/watch?v=yWB5Md7PHwU&t=21s
// I HOPE YOU ENJOY THE CHANGES


import Foundation
import SpriteKit


enum HelperStrings: String {
    
    case isFirstLaunch
    case buttonIcon = "ButtonPlay"
    case buttonRate = "ButtonRate"
    case buttonShare = "ButtonShare"
    case buttonBack = "ButtonBack"
    case buttonReplay = "ButtonReplay"
    case backgroundImage = "Background"
    case wideButtonIcon = "wideButton"
    case settingsButton = "gear"
    case volumeButton = "musico"
    case labelFont = "GlutenFT-Regular"
    case kSoundState
    case kMusicVolume
    case buttonMusic = "tap.mp3"
    case backgroundMusic = "BackgroundMusic"
    case mp3Extension = "mp3"
    case kScore
    case kBestScore
    case existingScore
    case appID = "???"
    case shareImg = "Donut13"
}

enum SceneType: CaseIterable {
    
    case mainMenu
    case gameplay
    case gameOver
}




//SINGLETON : OPERATIONS FOR GAME
class Manager {
    
    private init() {}
    
    //SHARED INSTANCE : ACCESS TO PUBLIC FUNCTIONS
    static let shared = Manager()
    
    public func launch() {
        
        firstLaunch()
    }
    
    //ONLY EXECUTED ON THE FIRST LAUNCH
    private func firstLaunch() {
        
        let isFirstLaunch = HelperStrings.isFirstLaunch.rawValue
        
        if !UserDefaults.standard.bool(forKey: isFirstLaunch) {
            
            print("This is our first launch.")
            Stats.shared.setSounds(true)
            Stats.shared.saveMusicVolume(0.8)
            
            UserDefaults.standard.set(true, forKey: isFirstLaunch)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil) {
        
        guard let scene = getScene(toScene) else { return }     //IF NO SCENE THEN SAFELY RETURN
        
        if let transition = transition {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transition)
        } else {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }
        
    }
    
    
    func getScene(_ sceneType: SceneType) -> SKScene? {
        
        switch sceneType {
        case .mainMenu : return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .gameplay : return Gameplay(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .gameOver : return GameOver(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        }
    }
    
    
    func run(_ soundFile: String, onNode: SKNode) {
        
        if Stats.shared.getSound() {
            onNode.run(SKAction.playSoundFileNamed(soundFile, waitForCompletion: false))
        }
    }
    
    
    func showAlert(on scene: SKScene, title: String, message: String, prefferedStyle: UIAlertController.Style = .alert, actions: [UIAlertAction], animated: Bool = true, delay: Double = 0.0, completion: (() -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: prefferedStyle)
        
        for action in actions {
            alert.addAction(action)
        }
        
        let wait = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: wait) {
            scene.view?.window?.rootViewController?.present(alert, animated: animated, completion: completion)      //PRESENT ON TOP OF SKSCENE
        }
    }
    
    
    func share(on scene: SKScene, text: String, image: UIImage?, excludedActivityTypes: [UIActivity.ActivityType]) {
        
        //THANK YOU ALEX NAGGI !
        guard let image = UIImage(named: HelperStrings.buttonIcon.rawValue) else { return } //PREVENT IMAGE FROM FORCE UNWRAP : AT LAST I KNOW !
        let shareItems = [text, image] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = scene.view   //PREVENT iPAD CRASH
        activityViewController.excludedActivityTypes = excludedActivityTypes            //EXCLUDE ACTIVITY TYPES FROM LIST (OPTIONAL)
        
        scene.view?.window?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}




