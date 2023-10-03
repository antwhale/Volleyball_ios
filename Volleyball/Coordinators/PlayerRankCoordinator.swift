//
//  PlayerRankCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/29.
//

import Foundation
import UIKit

protocol PlayerRankCoordinatorProtocol : Coordinator {
}

class PlayerRankCoordinator : PlayerRankCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .player_rank }
    
    func start() {
        let playerRankViewController = PlayerRankViewController()
        navigationController.setViewControllers([playerRankViewController], animated: false)
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
