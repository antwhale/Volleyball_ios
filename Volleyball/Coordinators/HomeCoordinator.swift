//
//  HomeCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/01.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol : Coordinator {
    
}

class HomeCoordinator : HomeCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .home }
    
    func start() {
        let homeViewController = HomeViewController()
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
