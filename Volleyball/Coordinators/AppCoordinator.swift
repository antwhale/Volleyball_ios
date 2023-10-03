//
//  MainCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/09.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

//App coordinator is the only one coordinator which will exist during app's life cycle
class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showIntroFlow()
    }
   
    func showLoginFlow() {
        //Implement Login Flow
        let loginCoordinator = LoginCoordinator.init(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showMainFlow() {
        //Implement Main (Tab bar) Flow
//        let tabCoordinator = TabCoordinator.init(navigationController)
//        tabCoordinator.finishDelegate = self
//        tabCoordinator.start()
//        childCoordinators.append(tabCoordinator)
        let mainCoordinator = MainCoordinator.init(navigationController)
        mainCoordinator.finishDelegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
    
    func showIntroFlow(){
        //Implement Intro Flow
        Log.debug("showIntroFlow")
        let introCoordinator = IntroCoordinator.init(navigationController)
        introCoordinator.finishDelegate = self
        introCoordinator.start()
        childCoordinators.append(introCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter ({ $0.type != childCoordinator.type})
        
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        case .intro:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        default:
            break
        }
    }
}
