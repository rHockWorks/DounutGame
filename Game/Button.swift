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



class Button: SKNode {
    
    var button: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode: SKCropNode
    private var action: () -> Void  //IMPLEMENT ACTION INSIDE SCENES
    var isEnabled = true
    var titleLabel: SKLabelNode?    //NOT ALL BUTTONS HAVE LABELS
    
    init(imageNamed: String, title: String? = "", buttonAction: @escaping () -> Void) {
        button = SKSpriteNode(imageNamed: imageNamed)
        titleLabel = SKLabelNode(text: title)
        
        mask = SKSpriteNode(color: UIColor.black, size: button.size)
        mask.alpha = 0
        
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        
        action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        
        
        setupNodes()
        addNodes()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupNodes() {
        
        button.zPosition = 0
        
        if let titleLabel = titleLabel {
            titleLabel.fontName = HelperStrings.labelFont.rawValue
            titleLabel.fontSize = CGFloat.universalFont(size: 20)
            titleLabel.fontColor = SKColor.white
            titleLabel.zPosition = 1
            titleLabel.horizontalAlignmentMode = .center
            titleLabel.verticalAlignmentMode = .center
        }
    }
    
    
    func addNodes() {
        
        addChild(button)
        if let titleLabel = titleLabel {
            addChild(titleLabel)
        }
        addChild(cropNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled == true {
            mask.alpha = 0.5
            run(SKAction.scale(to: 0.95, duration: 0.05))
        }
    }
    
    //DRAGGING AWAY FROM (ACCIDENTALLY) PRESSED BUTTON
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled == true {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location) {
                    mask.alpha = 0.5
                    run(SKAction.scale(to: 1.0, duration: 0.05))    //FIXME: ONLY TAKES ONE PIXEL, NOT FULLY AWAY FROM BUTTON
                } else {
                    mask.alpha = 0.0
                }
            }
        }
    }
    
    //PERFORM BUTTON ACTION
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled == true {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location) {
                    Manager.shared.run(HelperStrings.buttonMusic.rawValue, onNode: self)
                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run({
                        self.enable()
                    })]))
                }
            }
        }
    }
    
    
    func disable() {
        
        isEnabled = false
        mask.alpha = 0.0
        button.alpha = 0.0
    }
    
    func enable() {
        
        isEnabled = true
        mask.alpha = 0.0
        button.alpha = 1.0
    }
    

    
    
    //AUTO-SCALE BUTTON SIZE
    func scaleTo(screenWithPercentage: CGFloat) {
        
        let aspectRatio = button.size.height / button.size.width
        let screenWidth = ScreenSize.width
        var screenHeight = ScreenSize.height
        
        if DeviceType.isiPhoneX {
            screenHeight -= 80
        }
        button.size.width = screenWidth * screenWithPercentage
        button.size.height = button.size.width * aspectRatio
    }
}




