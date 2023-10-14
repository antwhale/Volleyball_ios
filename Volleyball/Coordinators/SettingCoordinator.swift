//
//  SettingCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/14.
//

import Foundation
import UIKit

protocol SettingCoordinatorProtocol : Coordinator {
    func showSettingViewController()
}

class SettingCoordinator : SettingCoordinatorProtocol{
    var finishDelegate: CoordinatorFinishDelegate?
    
    func start() {
        showSettingViewController()
    }
    
    static let tag = "SettingCoordinator"
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .setting
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("SettingCoordinator deinit")
    }
    
    func showSettingViewController() {
        Log.debug(SettingCoordinator.tag, "showSettingViewController")
        
        let settingViewController = SettingViewController()
        settingViewController.hidesBottomBarWhenPushed = true
        settingViewController.didFinishClosure = {  
            self.finish()
            self.navigationController.popViewController(animated: false)
        }
        navigationController.pushViewController(settingViewController, animated: false)
    }
}


