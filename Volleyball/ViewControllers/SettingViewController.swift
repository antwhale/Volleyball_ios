//
//  SettingViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SettingViewController : UIViewController {
    static let tag = "SettingViewController"
    
    let settingViewModel = SettingViewModel()
    
    var didFinishClosure : (() -> Void)?
    
    let subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = UIColor(named: "v9v9_color")
        label.font = UIFont.systemFont(ofSize: 16)

        return label
    }()
    
    let cheeringTeamCategoryLabel : UILabel = {
        let label = UILabel()
        label.text = "응원하는 팀"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let cheeringTeamLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        

        return label
    }()
    
    let cheeringTeamPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.setValue(UIColor.systemGray, forKeyPath: "textColor")
        return picker
    }()
    
    let teamList = ["GS칼텍스", "기업은행", "도로공사", "정관장", "페퍼저축은행", "현대거설", "흥국생명", "KB손해보험", "OK금융그룹", "대한항공", "삼성화재", "우리카드", "한국전력", "현대캐피탈", "기본"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        Log.debug(SettingViewController.tag, "viewDidLoad")
        
        initViews()
        setupLayout()
        initSubscribe()
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
        
        let cheeringTap1 = UITapGestureRecognizer(target: self, action: #selector(self.showCheeringTeam))
        let cheeringTap2 = UITapGestureRecognizer(target: self, action: #selector(self.showCheeringTeam))
        cheeringTeamLabel.addGestureRecognizer(cheeringTap2)
        cheeringTeamCategoryLabel.addGestureRecognizer(cheeringTap1)
        cheeringTeamPicker.isHidden = true
        
        let myteam = settingViewModel.getCheeringTeam()
        cheeringTeamLabel.text = teamList[myteam]

    }
    
    private func setupLayout() {
        Log.debug(SettingViewController.tag, "setupLayout")
        view.isUserInteractionEnabled = true
        
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        view.addSubview(cheeringTeamCategoryLabel)
        cheeringTeamCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        cheeringTeamCategoryLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor, constant: 10).isActive = true
        cheeringTeamCategoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cheeringTeamCategoryLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
//        cheeringTeamCategoryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(cheeringTeamLabel)
        cheeringTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        cheeringTeamLabel.leadingAnchor.constraint(equalTo: cheeringTeamCategoryLabel.leadingAnchor).isActive = true
        cheeringTeamLabel.trailingAnchor.constraint(equalTo: cheeringTeamCategoryLabel.trailingAnchor).isActive = true
        cheeringTeamLabel.topAnchor.constraint(equalTo: cheeringTeamCategoryLabel.bottomAnchor, constant: 5).isActive = true
        
        view.addSubview(cheeringTeamPicker)
        cheeringTeamPicker.translatesAutoresizingMaskIntoConstraints = false
        cheeringTeamPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cheeringTeamPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cheeringTeamPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc
    func showCheeringTeam(_ sender : UITapGestureRecognizer) {
        Log.debug(SettingViewController.tag, "showCheeringTeam")
        
        self.cheeringTeamPicker.isHidden = false
    }
    
    private func initSubscribe() {
        Log.debug(SettingViewController.tag, "initSubscribe")
        
        Observable.of(teamList)
            .bind(to: cheeringTeamPicker.rx.itemTitles) { _, item in
                    return "\(item)"
            }.disposed(by: disposeBag)
        
        self.cheeringTeamPicker.rx.itemSelected
            .subscribe(onNext: { [weak self] row, value in
                Log.debug(SettingViewController.tag, "row: \(row), value: \(value)")
                
                self?.cheeringTeamLabel.text = self?.teamList[row]
                
                self?.cheeringTeamPicker.isHidden = true
                
                self?.settingViewModel.saveCheeringTeam(team: row)
                
            }).disposed(by: disposeBag)
    }
    
    @objc
    private func clickBack() {
        Log.debug(SettingViewController.tag, "clickBack")
        
        self.didFinishClosure?()
    }
}
