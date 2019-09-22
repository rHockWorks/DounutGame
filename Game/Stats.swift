//
//  MainMenu.swift
//  Doughnut Game
//
//  Created by rHockWorks on 12/08/2019.
//  Copyright © 2019 rHockWorks. All rights reserved.
//
// THIS CODE IS MOSTLY FROM SAGNOR "ALEX" NAGY FROM REBELOPER.COM
// I HAVE SLIGHTLY MODIFIED THE CODE AS I WENT ALONG THE YOUTUBE TUTORIAL : https://www.youtube.com/watch?v=yWB5Md7PHwU&t=21s
// I HOPE YOU ENJOY THE CHANGES



//SINGLETON : CURRENT CONFIGURE / SET / SAVE
import Foundation
import SpriteKit
import StoreKit


class Stats {
    
    private init() {}
    static let shared = Stats()
    
    
    func setScore(_ value: Int) {
        
        if value > getBestScore() {     //CHECK IF NEW SCORE IS A PERSONAL BEST
            setBestScore(value)
        }
        
        UserDefaults.standard.set(value, forKey: HelperStrings.kScore.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getScore() -> Int {
        
        return UserDefaults.standard.integer(forKey: HelperStrings.kScore.rawValue)
    }
    
    func setBestScore(_ value: Int) {
        
        UserDefaults.standard.set(value, forKey: HelperStrings.kBestScore.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getBestScore() -> Int {
        
        return UserDefaults.standard.integer(forKey: HelperStrings.kBestScore.rawValue)
    }
    
    func setSounds(_ state: Bool) {
    
        UserDefaults.standard.set(state, forKey: HelperStrings.kSoundState.rawValue)
        UserDefaults.standard.synchronize()     //SAVE INTO MEMORY IMMEDIATELY, RATHER THAN AT THE COMPILER'S CONVENIENCE
    }
    
    func getSound() -> Bool {
        
        return UserDefaults.standard.bool(forKey: HelperStrings.kSoundState.rawValue)
    }
    
    func saveMusicVolume(_ value: Float) {
        
        UserDefaults.standard.set(value, forKey: HelperStrings.kMusicVolume.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getMusicVolume() -> Float {
        
        return UserDefaults.standard.float(forKey: HelperStrings.kMusicVolume.rawValue)
    }
    
    func rateGameRequest() {
        
        let personalBest: Int = Stats.shared.getBestScore()
        
        if personalBest != 0 || personalBest == personalBest + 200 {
            
            SKStoreReviewController.requestReview()
        }
    }


}
