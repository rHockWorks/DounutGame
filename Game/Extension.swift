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


import UIKit
import SpriteKit


// Screen height Cheat Sheet
// = 480.0  --  iPhone 4
// = 568.0  --  iPhone 5, iPhone5s, iPhone SE
// = 667.0  --  iPhone 6, iPhone 6 Plus, iPhone 6s, iPhone 6s Plus, iPhone 7, iPhone 8
// = 736.0  --  iPhone 7 Plus, iPhone 8 Plus
// = 812.0  --  iPhone X, iPhone Xs
// = 896.0  --  iPhone Xs Max, iPhone Xr
// = 1024.0 --  iPad Mini 4, iPad Air 2, iPad Pro 9.7"
// = 1112.0 --  iPad Pro 10.5"
// = 1194.0 --  iPad Pro 11"
// = 1366.0 --  iPad Pro 12.9" (both 1st and 2nd generations)







enum UserInterfaceIdiom: Int {
    
    case undefine
    case phone
    case pad
}

struct ScreenSize {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}


struct DeviceType {
    
    //static let ipadDevice = [isiPadMini4, isiPadAir2, isiPadPro97, isiPadPro105, isiPadPro11, isiPadPro129]
    
    static let isiPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength <= 480
    
    static let isiPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568
    static let isiPhone5S = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568
    static let isiPhoneSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568
    
    static let isiPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    static let isiPhone6Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    static let isiPhone6S = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    static let isiPhone6SPlus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    static let isiPhone7 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    static let isiPhone8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    
    static let isiPhone7Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736
    static let isiPhone8Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736
    
    static let isiPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812
    static let isiPhoneXS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812
    
    static let isiPhoneXSMax = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 896
    static let isiPhoneXR = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 896
    
    static let isiPadMini4 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024
    static let isiPadAir2 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024
    static let isiPadPro97 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024
    
    static let isiPadPro105 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1112
    static let isiPadPro11 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1194
    
    static let isiPadPro129 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1366
}


public extension CGFloat {
    
    static func universalFont(size: CGFloat) -> CGFloat {
        
        if DeviceType.isiPhone4OrLess {
            return size * 0.6
        }
        
        if DeviceType.isiPhone5 || DeviceType.isiPhone5S || DeviceType.isiPhoneSE {
            return size * 0.8
        }
        
        if DeviceType.isiPhone6 || DeviceType.isiPhone6Plus || DeviceType.isiPhone6S || DeviceType.isiPhone6SPlus || DeviceType.isiPhone7 || DeviceType.isiPhone7Plus || DeviceType.isiPhone8 || DeviceType.isiPhone8Plus  || DeviceType.isiPhoneX || DeviceType.isiPhoneXS || DeviceType.isiPhoneXSMax || DeviceType.isiPhoneXR {
            return size * 1.0
        }
        
        if DeviceType.isiPadMini4 || DeviceType.isiPadAir2 || DeviceType.isiPadPro97 || DeviceType.isiPadPro105 || DeviceType.isiPadPro11 || DeviceType.isiPadPro129 {
            return size * 2.1
            
        } else {
            
            return size * 1.0
        }
    }
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(_ min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}



extension SKSpriteNode {
    
    func popUp(after: CGFloat = 0.0, sequenceNumber: Int = 1) {
        let action2Duration = 0.2
        let action3Duration = 0.06
        let action4Duration = 0.1
        let action5Duration = 0.05
        let totalTimeOfPopUpAnimation = action2Duration + action3Duration + action4Duration + action5Duration
        let action0 = SKAction.scale(to: 0.0, duration: 0.0)
        let action1 = SKAction.wait(forDuration: TimeInterval(CGFloat(sequenceNumber) * CGFloat(totalTimeOfPopUpAnimation) + after))
        let action2 = SKAction.scale(to: 1.1, duration: action2Duration)
        let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
        let action4 = SKAction.scale(to: 1.05, duration: action4Duration)
        let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
        let sequence = SKAction.sequence([action0, action1, action2, action3, action4, action5])
        self.run(sequence)
    }
    
    func popDown(after: CGFloat = 0.0, sequenceNumber: Int = 1) {
        let action2Duration = 0.1
        let action3Duration = 0.03
        let action4Duration = 0.05
        let action5Duration = 0.02
        let totalTimeOfPopUpAnimation = action2Duration + action3Duration + action4Duration + action5Duration
        let action0 = SKAction.scale(to: 1.0, duration: 0.0)
        let action1 = SKAction.wait(forDuration: TimeInterval(CGFloat(sequenceNumber) * CGFloat(totalTimeOfPopUpAnimation) + after))
        let action2 = SKAction.scale(to: 1.9, duration: action2Duration)
        let action3 = SKAction.scale(to: 1.7, duration: action3Duration)
        let action4 = SKAction.scale(to: 1.85, duration: action4Duration)
        let action5 = SKAction.scale(to: 0.0, duration: action5Duration)
        let sequence = SKAction.sequence([action0, action1, action2, action3, action4, action5])
        self.run(sequence)
    }
    
    func bounce() {
        let action2Duration = 0.3
        let action3Duration = 0.12
        let action4Duration = 0.2
        let action5Duration = 0.1
        let action2 = SKAction.scale(to: 1.2, duration: action2Duration)
        let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
        let action4 = SKAction.scale(to: 1.1, duration: action4Duration)
        let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
        let sequence = SKAction.sequence([action2, action3, action4, action5])
        self.run(sequence)
    }
    
    func bounceLockedButton() {
        let action2Duration = 0.15
        let action3Duration = 0.06
        let action4Duration = 0.1
        let action5Duration = 0.05
        let action2 = SKAction.scale(to: 1.2, duration: action2Duration)
        let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
        let action4 = SKAction.scale(to: 1.1, duration: action4Duration)
        let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
        let sequence = SKAction.sequence([action2, action3, action4, action5])
        self.run(sequence)
    }
    
    func bounceCookie() {
        let action2Duration = 0.3
        let action3Duration = 0.12
        let action4Duration = 0.2
        let action5Duration = 0.1
        let action2 = SKAction.scale(to: 1.6, duration: action2Duration)
        let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
        let action4 = SKAction.scale(to: 1.3, duration: action4Duration)
        let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
        let sequence = SKAction.sequence([action2, action3, action4, action5])
        self.run(sequence)
    }
    
    func rotate(speed: Int, clockWise: Bool) {
        let angel = clockWise ? CGFloat(-.pi/2.0) : CGFloat(.pi/2.0)
        let rotateForever = SKAction.repeatForever(SKAction.rotate(byAngle: angel, duration: TimeInterval(speed)))
        self.run(rotateForever)
    }
    
    func swing(speed: Int, startClockWise: Bool, angle: CGFloat) {
        let swingRight = SKAction.rotate(toAngle: .pi/angle, duration: TimeInterval(speed))
        let swingLeft = SKAction.rotate(toAngle: -.pi/angle, duration: TimeInterval(speed))
        let sequence = startClockWise ? SKAction.sequence([swingRight, swingLeft]) : SKAction.sequence([swingLeft, swingRight])
        let swingForever = SKAction.repeatForever(sequence)
        self.run(swingForever)
    }
    
    func slide(speed: Int, distanceX: CGFloat, distanceY: CGFloat) {
        let slide = SKAction.moveBy(x: distanceX , y: distanceY, duration: TimeInterval(speed))
        let slideBack = SKAction.moveBy(x: -distanceX , y: -distanceY, duration: TimeInterval(speed))
        let slideLeftRight = SKAction.sequence([slide, slideBack])
        let slideForever = SKAction.repeatForever(slideLeftRight)
        self.run(slideForever)
    }
    
//    func fadeUp() {
//        let randomWait = SKAction.wait(forDuration: TimeInterval(CGFloat.random(0.0, max: 0.2)))
//        let growAction = SKAction.scale(to: CGFloat.random(3.0, max: 5.0), duration: TimeInterval(CGFloat.random(1.0, max: 1.5)))
//        let fadeOutAction = SKAction.fadeOut(withDuration: TimeInterval(CGFloat.random(1.0, max: 1.5)))
//        let group = SKAction.group([growAction, fadeOutAction])
//        self.run(SKAction.sequence([randomWait, group]))
//    }
    
    func scaleTo(screenWidthPercentage: CGFloat) {
        
        let aspectRatio = self.size.height / self.size.width
        self.size.width = ScreenSize.width * screenWidthPercentage
        self.size.height = self.size.width * aspectRatio
    }
    
    func scaleTo(screenHeightPercentage: CGFloat) {
        
        let aspectRatio = self.size.width / self.size.width
        self.size.height = ScreenSize.height * screenHeightPercentage
        self.size.width = self.size.height * aspectRatio
    }
}

extension SKLabelNode {
    func popUp(after: CGFloat = 0.0, sequenceNumber: Int = 1) {
        let action2Duration = 0.2
        let action3Duration = 0.06
        let action4Duration = 0.1
        let action5Duration = 0.05
        let totalTimeOfPopUpAnimation = action2Duration + action3Duration + action4Duration + action5Duration
        let action0 = SKAction.scale(to: 0.0, duration: 0.0)
        let action1 = SKAction.wait(forDuration: TimeInterval(CGFloat(sequenceNumber) * CGFloat(totalTimeOfPopUpAnimation) + after))
        let action2 = SKAction.scale(to: 1.1, duration: action2Duration)
        let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
        let action4 = SKAction.scale(to: 1.05, duration: action4Duration)
        let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
        let sequence = SKAction.sequence([action0, action1, action2, action3, action4, action5])
        self.run(sequence)
    }
}
