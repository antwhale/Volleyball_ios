//
//  SettingViewModel.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/15.
//

import Foundation
import UIKit

class SettingViewModel {
    static let tag = "SettingViewModel"
    
    func saveCheeringTeam(team : Int) {
        Log.debug(SettingViewModel.tag, "saveCheeringTeam : \(team)")
        
        UserDefaults.standard.set(team, forKey: "MyTeam")
    }
    
    func getCheeringTeam() -> Int {
        return UserDefaults.standard.integer(forKey: "MyTeam")
    }
}
