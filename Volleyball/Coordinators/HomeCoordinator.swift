//
//  HomeCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/01.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol : Coordinator {
    func goToSettingViewController()
}

class HomeCoordinator : HomeCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .home }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.clickSettingIcon = {
            self.goToSettingViewController()
        }
        navigationController.setViewControllers([homeViewController], animated: false)
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

extension HomeCoordinator : CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        Log.debug(PlayerRankCoordinator.tag, "coordinatorDidFinish")
        
        childCoordinators = childCoordinators.filter ({ $0.type != childCoordinator.type})

    }
}
