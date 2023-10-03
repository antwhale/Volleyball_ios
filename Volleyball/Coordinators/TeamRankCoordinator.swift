//
//  TeamRankCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/29.
//

import Foundation
import UIKit

protocol TeamRankCoordinatorProtocol : Coordinator {
}

class TeamRankCoordinator : TeamRankCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .team_rank }
    
    func start() {
        let teamRankViewController = TeamRankViewController()
        navigationController.setViewControllers([teamRankViewController], animated: false)
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
}
