//
//  TabBarPage.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/10.
//

import Foundation

enum TabBarPage {
    case ready
    case steady
    case go
    
    init?(index: Int) {
        switch index {
            case 0:
                self = .ready
            case 1:
                self = .steady
            case 2:
                self = .go
            default:
                return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
            case .ready:
                return "Ready"
            case .steady:
                return "steady"
            case .go:
                return "Go"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .ready:
            return 0
        case .steady:
            return 1
        case .go:
            return 2
        }
    }
    
    //Add tab icon valuse
    
    //Add tab icon selected / deselected color
    
    //etc
}
