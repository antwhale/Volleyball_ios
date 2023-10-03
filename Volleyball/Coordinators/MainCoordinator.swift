//
//  MainCoordinator.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/16.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol : Coordinator {
    var tabBarController : UITabBarController { get set }
    
    func selectPage(_ page: MainTabBarPage)
    
    func setSelectedIndex(_ index : Int)
    
    func currentPage() -> MainTabBarPage?
}

class MainCoordinator : NSObject, MainCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController : UINavigationController
    
    var tabBarController: UITabBarController
    
    var type: CoordinatorType { .main }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        //Let's define which pages do we want to add into tab bar
        let pages: [MainTabBarPage] = [.home, .schedule, .news, .team_rank, .player_rank]
            .sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber()})
        
        //Initialization of ViewControllers or these pages
        let controllers : [UINavigationController] = pages.map({getTabController($0)})
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        Log.debug("MainCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers : [UIViewController]) {
        Log.debug("MainCoordinator - prepareTabBarController")
        
        //Set delegate for UITabBarController
        tabBarController.delegate = self
        
        //Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        
        //Lets set index
        tabBarController.selectedIndex = MainTabBarPage.home.pageOrderNumber()
        
        //Styling
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        
        //In this step, we attach tabBarController to navigation controller associated with
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: MainTabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageTabIcon(),
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .home:
            Log.debug("getTabController - main")
            //If needed: Each tab bar flow can have its own Coordinator
//            let homeVC = HomeViewController()
//            navController.pushViewController(homeVC, animated: true)
            let homeCoordinator = HomeCoordinator(navController)
            homeCoordinator.start()
            childCoordinators.append(homeCoordinator)
            return homeCoordinator.navigationController
            
        case .schedule:
            Log.debug("getTabController - sehedule")
            let scheduleVC = ScheduleViewController()
            navController.pushViewController(scheduleVC, animated: true)
            
        case .news:
            Log.debug("getTabController - news")
//            let newsVC = NewsViewController()
//            navController.pushViewController(newsVC, animated: true)
            let newsCoordinator = NewsCoordinator(navController)
            newsCoordinator.start()
            childCoordinators.append(newsCoordinator)
            return newsCoordinator.navigationController

        case .team_rank:
            Log.debug("getTabController - team_rank")
//            let teamRankVC = TeamRankViewController()
//            navController.pushViewController(teamRankVC, animated: true)
            let teamRankCoordinator = TeamRankCoordinator(navController)
            teamRankCoordinator.start()
            childCoordinators.append(teamRankCoordinator)
            return teamRankCoordinator.navigationController

        case .player_rank:
            Log.debug("getTabController - player_rank")
//            let playerRankVC = PlayerRankViewController()
//            navController.pushViewController(playerRankVC, animated: true)
            let playerRankCoordinator = PlayerRankCoordinator(navController)
            playerRankCoordinator.start()
            childCoordinators.append(playerRankCoordinator)
            return playerRankCoordinator.navigationController
        }
        
        return navController
    }
    
    func currentPage() -> MainTabBarPage? {
        MainTabBarPage.init(index: tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: MainTabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = MainTabBarPage.init(index: index) else {return}
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

//MARK : UITabBarControllerDelegate
extension MainCoordinator : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //Some implementation
        Log.debug("tabBarController called")
        childCoordinators.removeAll()
        
//        childCoordinators.append(<#T##newElement: Coordinator##Coordinator#>)
    }
}
