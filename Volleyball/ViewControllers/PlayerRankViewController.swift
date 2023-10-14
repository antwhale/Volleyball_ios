//
//  PlayerRankViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import UIKit
import WebKit

class PlayerRankViewController: UIViewController {
    static let tag = "PlayerRankViewController"
    
    private var webView: WKWebView!
    var clickSettingIcon : (() -> Void)?

    override func viewDidLoad(){
        super.viewDidLoad()
        
        initViews()
        initWebView()
    }
    
    private func initViews() {
        Log.debug(PlayerRankViewController.tag, "initViews")
        
        let mainAppearance = UINavigationBarAppearance()
        mainAppearance.backgroundColor = UIColor(named: "v9v9_color")
        self.navigationController?.navigationBar.scrollEdgeAppearance = mainAppearance
        self.navigationController?.navigationBar.standardAppearance = mainAppearance
        self.navigationItem.title = "배구배구"
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(clickSetting))
        
        
    }
    
    @objc
    private func clickSetting() {
        Log.debug(PlayerRankViewController.tag, "clickSetting")
        self.clickSettingIcon?()
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

        let playerRankUrl = URL(string: "https://kovo.co.kr/KOVO/stats/player-record")
        let playerRankRequest = URLRequest(url: playerRankUrl!)
        webView.load(playerRankRequest)
    }
}



extension PlayerRankViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Log.debug("message : \(message.name)")
    }
}
