//
//  TeamRankCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/29.
//

import Foundation
import UIKit

protocol TeamRankCoordinatorProtocol : Coordinator {
    func goToSettingViewController()

}

class TeamRankCoordinator : TeamRankCoordinatorProtocol {
    static let tag = "TeamRankCoordinatorProtocol"
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .team_rank }
    
    func start() {
        let teamRankViewController = TeamRankViewController()
        teamRankViewController.clickSettingIcon = {
            self.goToSettingViewController()
        }
        navigationController.setViewControllers([teamRankViewController], animated: false)
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

extension TeamRankCoordinator : CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        Log.debug(TeamRankCoordinator.tag, "coordinatorDidFinish")
        
        childCoordinators = childCoordinators.filter ({ $0.type != childCoordinator.type})
    }
}
