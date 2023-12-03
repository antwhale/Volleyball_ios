//
//  TeamRankViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxRelay


class TeamRankViewController: UIViewController {
    static let tag = "TeamRankViewController"
    var clickSettingIcon : (() -> Void)?
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .systemRed
        return scrollView
    }()
    
    let scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
    let manTableTitle : UILabel = {
        let label = UILabel()
        label.text = "남자부 팀 순위"
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let manTeamTableHeaderView : TeamTableHeaderView = {
        let view = TeamTableHeaderView()
        
        return view
    }()
    
    let manTeamTableContentView : TeamTableContentView = {
        let view = TeamTableContentView()
    
        return view
    }()
    
    let womanTableTitle : UILabel = {
        let label = UILabel()
        label.text = "여자부 팀 순위"
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let womanTeamTableHeaderView : TeamTableHeaderView = {
        let view = TeamTableHeaderView()
        
        return view
    }()
    
    let womanTeamTableContentView : TeamTableContentView = {
        let view = TeamTableContentView()
    
        return view
    }()
    
    
    private let teamRankViewModel = TeamRankViewModel()
    
    let defaultUrl = "https://kovo.co.kr/KOVO/stats/team-record"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        setupLayout()
        
        teamRankViewModel.manTeamRankSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.manTeamTableContentView.setContent(contents: data)

            }, onError: { error in
                Log.error(TeamRankViewController.tag, error.localizedDescription)
            }).disposed(by: disposeBag)
        
        teamRankViewModel.womanTeamRankSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.womanTeamTableContentView.setContent(contents: data)
            }, onError: { error in
                Log.error(TeamRankViewController.tag, error.localizedDescription)
            }).disposed(by: disposeBag)
        
        teamRankViewModel.getMansRank()
        
        teamRankViewModel.getWomansRank()
        
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
        
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        Log.debug(TeamRankViewController.tag, "setUpLayout")
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(scrollContentView)
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        
        scrollContentView.addSubview(manTableTitle)
        manTableTitle.translatesAutoresizingMaskIntoConstraints = false
        manTableTitle.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 8).isActive = true
        manTableTitle.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 16).isActive = true
        
        scrollContentView.addSubview(manTeamTableHeaderView)
        manTeamTableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        manTeamTableHeaderView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        manTeamTableHeaderView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        manTeamTableHeaderView.topAnchor.constraint(equalTo: manTableTitle.bottomAnchor, constant: 8).isActive = true
        
        scrollContentView.addSubview(manTeamTableContentView)
        manTeamTableContentView.translatesAutoresizingMaskIntoConstraints = false
        manTeamTableContentView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        manTeamTableContentView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        manTeamTableContentView.topAnchor.constraint(equalTo: manTeamTableHeaderView.bottomAnchor, constant: 5).isActive = true

        scrollContentView.addSubview(womanTableTitle)
        womanTableTitle.translatesAutoresizingMaskIntoConstraints = false
        womanTableTitle.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 8).isActive = true
        womanTableTitle.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanTableTitle.topAnchor.constraint(equalTo: manTeamTableContentView.bottomAnchor, constant: 16).isActive = true
        
        scrollContentView.addSubview(womanTeamTableHeaderView)
        womanTeamTableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        womanTeamTableHeaderView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        womanTeamTableHeaderView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanTeamTableHeaderView.topAnchor.constraint(equalTo: womanTableTitle.bottomAnchor, constant: 8).isActive = true
        
        scrollContentView.addSubview(womanTeamTableContentView)
        womanTeamTableContentView.translatesAutoresizingMaskIntoConstraints = false
        womanTeamTableContentView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        womanTeamTableContentView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanTeamTableContentView.topAnchor.constraint(equalTo: womanTeamTableHeaderView.bottomAnchor, constant: 5).isActive = true
    }
    
    @objc
    private func clickSetting() {
        Log.debug(TeamRankViewController.tag, "clickSetting")
        self.clickSettingIcon?()
    }
    

    
}
