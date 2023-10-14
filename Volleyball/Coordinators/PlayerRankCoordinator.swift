//
//  PlayerRankCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/29.
//

import Foundation
import UIKit

protocol PlayerRankCoordinatorProtocol : Coordinator {
    func goToSettingViewController()
}

class PlayerRankCoordinator : PlayerRankCoordinatorProtocol {
    static let tag = "PlayerRankCoordinator"
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .player_rank }
    
    func start() {
        let playerRankViewController = PlayerRankViewController()
        playerRankViewController.clickSettingIcon = {
            self.goToSettingViewController()
        }
        navigationController.setViewControllers([playerRankViewController], animated: false)
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToSettingViewController() {
        Log.debug(PlayerRankCoordinator.tag, "goToSettingViewController")
        
        let settingCoordinator = SettingCoordinator(navigationController)
        settingCoordinator.finishDelegate = self
        childCoordinators.append(settingCoordinator)
        settingCoordinator.start()
    }
}

extension PlayerRankCoordinator : CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        Log.debug(PlayerRankCoordinator.tag, "coordinatorDidFinish")
        
        childCoordinators = childCoordinators.filter ({ $0.type != childCoordinator.type})

    }
}
