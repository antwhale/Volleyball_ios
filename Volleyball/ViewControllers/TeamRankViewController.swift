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

    private var myWebView: WKWebView!
    let defaultUrl = "https://kovo.co.kr/KOVO/stats/team-record"
    
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
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "bridge")
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        
        myWebView = WKWebView(frame: self.view.bounds, configuration: configuration)
        myWebView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        myWebView.addObserver(self, forKeyPath: "URL", context: nil)
        
        view.addSubview(myWebView)
        myWebView.translatesAutoresizingMaskIntoConstraints = false
        myWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myWebView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loadDefaultUrl()
    }
    
    @objc
    private func clickSetting() {
        Log.debug(TeamRankViewController.tag, "clickSetting")
        self.clickSettingIcon?()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        Log.debug(TeamRankViewController.tag, "observe URL Value")
        
        if keyPath == #keyPath(WKWebView.url) {
            //Whenever URL changes, it can be accessed via WKWebView instance
            let urlStr = myWebView.url?.absoluteString ?? ""
            
            if !urlStr.contains("https://kovo.co.kr/KOVO/stats/") {
                makeAlertDialog()
            }
        }
    }
    
    private func makeAlertDialog() {
        Log.debug(TeamRankViewController.tag, "makeAlertDialog")
        
        let alertController = UIAlertController(title: "알림", message: "기록 외의 페이지에는 접근할 수 없습니다", preferredStyle: .alert)
        let alertSuccessBtn = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            self?.loadDefaultUrl()
        }
        
        alertController.addAction(alertSuccessBtn)
        
        self.present(alertController, animated: false, completion: nil)
    }
    
    private func loadDefaultUrl() {
        Log.debug(TeamRankViewController.tag, "loadDefaultUrl")
        
        let teamRankUrl = URL(string: defaultUrl)
        let teamRankRequest = URLRequest(url: teamRankUrl!)
        myWebView.load(teamRankRequest)
    }
}

extension TeamRankViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Log.debug("message : \(message.name)")
    }
}
