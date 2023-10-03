//
//  NewsCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/23.
//

import Foundation
import UIKit

protocol NewsCoordinatorProtocol : Coordinator {
    func showNewsDetailController()
}

class NewsCoordinator : NewsCoordinatorProtocol {
    let tag = "NewsCoordinator"
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController : UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .news
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        let newsViewController = NewsViewController()
        newsViewController.openNewsClosure = { urlString in
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        navigationController.setViewControllers([newsViewController], animated: false)
    }
    
    func showNewsDetailController() {
        Log.debug(tag, "showNewsDetailController")
    }
}
