//
//  IntroCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/16.
//

import Foundation
import UIKit

protocol IntroCoordinatorProtocol : Coordinator {
    func showIntroViewController()
}

class IntroCoordinator : IntroCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .intro
    
    func start() {
        showIntroViewController()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("IntroCoordinatorProtocol deinit")
    }
    
    func showIntroViewController() {
        print("showMainViewController")
        
        let introVC: IntroViewController = .init()
        introVC.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        
        navigationController.pushViewController(introVC, animated: true)
    }
    
}
