//
//  SettingViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/14.
//

import Foundation
import UIKit

class SettingViewController : UIViewController {
    static let tag = "SettingViewController"
    
    var didFinishClosure : (() -> Void)?

    override func viewDidLoad() {
        Log.debug(SettingViewController.tag, "viewDidLoad")
        
        initViews()
    }
    
    private func initViews() {
        Log.debug(TeamRankViewController.tag, "initViews")
        
        view.backgroundColor = .white
        
        let mainAppearance = UINavigationBarAppearance()
        mainAppearance.backgroundColor = UIColor(named: "v9v9_color")
        self.navigationController?.navigationBar.scrollEdgeAppearance = mainAppearance
        self.navigationController?.navigationBar.standardAppearance = mainAppearance
        self.navigationItem.title = "배구배구"
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"), style: .plain, target: self, action: #selector(clickBack))
        
    }
    
    @objc
    private func clickBack() {
        Log.debug(SettingViewController.tag, "clickBack")
        
        self.didFinishClosure?()
    }
}
