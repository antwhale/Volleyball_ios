//
//  TabCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/14.
//

import Foundation
import UIKit

protocol TabCoordinatorProtocol : Coordinator {
    var tabBarController : UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index : Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator : NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators : [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    var type: CoordinatorType {.tab}
    
    required init (_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        //Let's define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [.go, .steady, .ready]
            .sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber()})
        
        //Initialization of ViewControllers or these pages
        let controllers : [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers : controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers : [UIViewController]) {
        //Set delegate for UITabBarController
        tabBarController.delegate = self
        
        //Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        
        //Lets set index
        tabBarController.selectedIndex = TabBarPage.ready.pageOrderNumber()
        
        //Styling
        tabBarController.tabBar.isTranslucent = false
        
        //In this step, we attach tabBarController to navigation controller associated with
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                    image: nil,
                                                    tag: page.pageOrderNumber())
        
        switch page {
        case .ready:
            print("getTabController - ready")
            //If needed: Each tab bar flow can have it's own Coordinator.
            let readyVC = ReadyViewController()
            readyVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .ready:
                    self?.selectPage(.steady)
                }
            }
            navController.pushViewController(readyVC, animated: true)
            
        case .steady:
            print("getTabController - steady")
            let steadyVC = SteadyViewController()
            steadyVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .steady :
                    self?.selectPage(.go)
                }
                
            }
            navController.pushViewController(steadyVC, animated: true)
            
        case .go:
            print("getTabController - go")
            let goVC = GoViewController()
            goVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .go :
                    self?.finish()
                }
            }
            navController.pushViewController(goVC, animated: true)
            
            
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex)}
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

//MARK : UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController : UIViewController) {
        //Some implementation
        print("tabBarController called")
        
//        let currentPage = TabBarPage.init(index: tabBarController.selectedIndex)
//        switch currentPage {
//        case .steady:
//
//        }
    }
}
