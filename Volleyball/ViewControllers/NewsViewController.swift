//
//  NewsViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class NewsViewController: UIViewController {
    static let tag = "NewsViewController"
    
    var clickSettingIcon : (() -> Void)?

    private var newsViewModel = NewsViewModel()
    private let tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(XmlNewsCell.self, forCellReuseIdentifier: XmlNewsCell.reuseIdentifier)
        tableView.rowHeight = 200
        return tableView
    }()

    var openNewsClosure : ((String) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Log.debug(NewsViewController.tag, "viewDidLoad")
        view.backgroundColor = .darkGray
        
        setupLayout()
        initViews()
        subscribeInit()
    }
    
    private func initViews() {
        Log.debug(NewsViewController.tag, "initViews")
        
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
    
    private func setupLayout() {
        Log.debug(NewsViewController.tag, "setupLayout")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func subscribeInit() {
        Log.debug(NewsViewController.tag, "subscribeInit")
        
        newsViewModel.newsItemsSubject.subscribe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items) {(tableView: UITableView, index: Int, element: XmlNewsData) -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: XmlNewsCell.reuseIdentifier) as? XmlNewsCell else {fatalError()}
                print("hihi, element: \(element.title) and \(element.imgUrl)")
                cell.setTitle(newsTitle: element.title)
                
                if(element.imgUrl.isEmpty) {
                    cell.setThumbnail(imgUrl: nil)
                } else {
                    cell.setThumbnail(imgUrl: URL(string: element.imgUrl)!)
                }
                
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(XmlNewsData.self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] element in
                Log.debug(NewsViewController.tag, "click \(element) item")
                
                self?.openNewsClosure?(element.link)
                
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Log.debug(NewsViewController.tag, "viewWillAppear")
        
        newsViewModel.fetchNewsItems()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Log.debug(NewsViewController.tag, "viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Log.debug(NewsViewController.tag, "viewDidDisappear")
    }
    
    deinit {
        Log.debug(NewsViewController.tag, "NewsViewController deinit")
    }
}

extension NewsViewController {
    enum Event {
        case detailNews
    }
}
