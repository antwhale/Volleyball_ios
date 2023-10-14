//
//  ScheduleCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/15.
//

import Foundation
import UIKit

protocol ScheduleCoordinatorProtocol : Coordinator {
    func goToSettingViewController()
}

class ScheduleCoordinator : ScheduleCoordinatorProtocol {
    static let tag = "ScheduleCoordinator"
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .schedule }
    
    func start() {
        let scheduleViewController = ScheduleViewController()
        scheduleViewController.clickSettingIcon = {
            self.goToSettingViewController()
        }
        navigationController.setViewControllers([scheduleViewController], animated: false)
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToSettingViewController() {
        Log.debug(ScheduleCoordinator.tag, "goToSettingViewController")
        
        let settingCoordinator = SettingCoordinator(navigationController)
        settingCoordinator.finishDelegate = self
        childCoordinators.append(settingCoordinator)
        settingCoordinator.start()
    }
}

extension ScheduleCoordinator : CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        Log.debug(ScheduleCoordinator.tag, "coordinatorDidFinish")
        
        childCoordinators = childCoordinators.filter ({ $0.type != childCoordinator.type})
    }
}
