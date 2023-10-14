//
//  TeamRankViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import UIKit
import WebKit


class TeamRankViewController: UIViewController {
    static let tag = "TeamRankViewController"
    var clickSettingIcon : (() -> Void)?

    private var webView: WKWebView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        initViews()
        initWebView()
    }
    
    private func initViews() {
        Log.debug(TeamRankViewController.tag, "initViews")
        
        let mainAppearance = UINavigationBarAppearance()
        mainAppearance.backgroundColor = UIColor(named: "v9v9_color")
        self.navigationController?.navigationBar.scrollEdgeAppearance = mainAppearance
        self.navigationController?.navigationBar.standardAppearance = mainAppearance
        self.navigationItem.title = "배구배구"
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(clickSetting))
    }
    
    private func initWebView() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "bridge")
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let teamRankUrl = URL(string: "https://kovo.co.kr/KOVO/stats/team-record")
        let teamRankRequest = URLRequest(url: teamRankUrl!)
        webView.load(teamRankRequest)
    }
    
    @objc
    private func clickSetting() {
        Log.debug(TeamRankViewController.tag, "clickSetting")
        self.clickSettingIcon?()
    }
}

extension TeamRankViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Log.debug("message : \(message.name)")
    }
}
