//
//  MainTabBarPage.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/16.
//

import Foundation
import UIKit

enum MainTabBarPage {
    case home
    case schedule
    case news
    case team_rank
    case player_rank
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .schedule
        case 2:
            self = .news
        case 3:
            self = .team_rank
        case 4:
            self = .player_rank
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "배구배구"
        case .schedule:
            return "경기일정"
        case .news:
            return "배구뉴스"
        case .team_rank:
            return "팀순위"
        case .player_rank:
            return "선수순위"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .schedule:
            return 1
        case .news:
            return 2
        case .team_rank:
            return 3
        case .player_rank:
            return 4
        }
    }
    
    //Add tab icon valuse
    func pageTabIcon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "home_tab_icon")
        case .schedule:
            return UIImage(named: "schedule_tab_icon")
        case .news:
            return UIImage(named: "news_tab_icon")
        case .team_rank:
            return UIImage(named: "team_rank_tab_icon")
        case .player_rank:
            return UIImage(named: "player_rank_tab_icon")
        }
    }
    //Add tab icon selected / deselected color
    
    //etc
}


