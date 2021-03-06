//
//  UserDefault.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import Foundation

final class FirstLaunch {
    let userDefaults: UserDefaults = .standard
    let wasLaunchedBefore: Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore }
    
    init() {
        let key = "com.any-suggestion.FirstLaunch.WasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore { userDefaults.set(true, forKey: key) }
    }
}


