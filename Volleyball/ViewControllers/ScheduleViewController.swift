//
//  ScheduleViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import UIKit
import WebKit

class ScheduleViewController: UIViewController {
    private var webView: WKWebView!
    private let baseScheduleUrl = "https://m.sports.naver.com/volleyball/schedule/index?date="
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        initWebView()
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
//    https://m.sports.naver.com/volleyball/schedule/index?date=2023-10-15
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.string(from: nowDate)
        
        let scheduleUrl = URL(string: baseScheduleUrl + convertDate)
        let scheduleRequest = URLRequest(url: scheduleUrl!)
        webView.load(scheduleRequest)
    }
}

extension ScheduleViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Log.debug("message : \(message.name)")
    }
}
