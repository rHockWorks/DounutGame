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

import SpriteKit


class MainMenu: SKScene {
    
    var background: SKSpriteNode = {
        
        var sprite = SKSpriteNode(imageNamed: HelperStrings.backgroundImage.rawValue)
        if DeviceType.isiPadAir2 || DeviceType.isiPadMini4 || DeviceType.isiPadPro11 || DeviceType.isiPadPro105 || DeviceType.isiPadPro129 || DeviceType.isiPadPro97 {
        sprite.scaleTo(screenHeightPercentage: 1.0)
        } else {
            sprite.scaleTo(screenWidthPercentage: 1.0)
        }
        sprite.zPosition = 0
        return sprite
    }()
    
    
    var title: SKLabelNode = {
        
        var label = SKLabelNode(fontNamed: HelperStrings.labelFont.rawValue)
        label.fontSize = CGFloat.universalFont(size: 40)
        label.zPosition = 2
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Pick Doughnut"
         return label
    }()

    
    //SPRITEKIT DEINITIALISES THE BUTTON AFTER TRANSITIONING TO SCENE
    lazy var playButton: Button = {
        
        var button = Button(imageNamed: HelperStrings.buttonIcon.rawValue, buttonAction: {
            Manager.shared.transition(self, toScene: .gameplay, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        })

        //startGameplay()
        button.scaleTo(screenWithPercentage: 0.33)
        button.zPosition = 1
        return button
    }()
    
    
     lazy var rateButton: Button = {
        
        let appID: String = HelperStrings.appID.rawValue
        var button = Button(imageNamed: HelperStrings.buttonRate.rawValue, buttonAction: {
            
            if let url = URL(string: "https://itunes.apple.com/app/id\(appID)?actions-write-review/") {    //FIXME: GET APP STORE APP URL !!
                UIApplication.shared.open(url, options: [:]) { (result) in
                    if result  {
                        print("success")
                    } else {
                        print("fail")
                    }
                }
            }
        })
        
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()


    lazy var shareButton: Button = {
        
        var button = Button(imageNamed: HelperStrings.buttonShare.rawValue, buttonAction: {
            
            Manager.shared.share(on: self, text: "Pass the time on the bog!", image: UIImage(named: HelperStrings.shareImg.rawValue), excludedActivityTypes: [.markupAsPDF])
        })
        
        button.scaleTo(screenWithPercentage: 0.27)
        button.zPosition = 1
        return button
    }()

    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)   //CENTRE OF SCENE
        setupNodes()
        addNodes()
    }
    
    func setupNodes() {
        
        background.position = CGPoint.zero
        playButton.position = CGPoint.zero
        title.position = CGPoint(x: ScreenSize.width * 0.0, y: ScreenSize.height * 0.25)
        rateButton.position = CGPoint(x: ScreenSize.width * -0.20, y: ScreenSize.height * -0.15)
        shareButton.position = CGPoint(x: ScreenSize.width * 0.20, y: ScreenSize.height * -0.15)
    }
    
    
    func addNodes() {
        
        addChild(background)
        addChild(title)
        addChild(playButton)
        addChild(rateButton)
        addChild(shareButton)
    }
    
    @objc func startGameplayNotification(_ info: Notification) {
        
        startGameplay()
    }
    
    func startGameplay() {
        
        Manager.shared.transition(self, toScene: .gameplay, transition: SKTransition.moveIn(with: .right, duration: 0.5))
    }
}
