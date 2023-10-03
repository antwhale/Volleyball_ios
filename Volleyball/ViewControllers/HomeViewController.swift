//
//  HomeViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let tag = "HomeViewController"
    private var homeViewModel = HomeViewModel()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .brown
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let todayMatchLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "오늘의 경기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let manMatchDateLabel1 : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
//        label.text = "10월 14일 (토) 14:00"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let manMatchPlaceLabel1 : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
//        label.text = "장충체육관"
        label.textColor = .systemGray
        label.font = label.font.withSize(14)
        return label
    }()
    
    let manMatchRoundLabel1 : UILabel = {
        let label = UILabel()
         label.textAlignment = .center
//         label.text = "1Round"
         label.textColor = .systemGray2
         label.font = label.font.withSize(14)
         return label
    }()
    
    let manMatchTeamLabel1 : UILabel = {
        let label = UILabel()
         label.textAlignment = .center
//         label.text = "우리카드 vs 현대캐피탈"
        label.textColor = .black
         label.font = label.font.withSize(16)
         return label
    }()
    
    let womanMatchDateLabel1 : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
//        label.text = "10월 14일 (토) 17:00"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let womanMatchPlaceLabel1 : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
//        label.text = "삼양체육관"
        label.textColor = .systemGray
        label.font = label.font.withSize(14)
        return label
    }()
    
    let womanMatchRoundLabel1 : UILabel = {
        let label = UILabel()
         label.textAlignment = .center
//         label.text = "1Round"
         label.textColor = .systemGray2
         label.font = label.font.withSize(14)
         return label
    }()
    
    let womanMatchTeamLabel1 : UILabel = {
        let label = UILabel()
         label.textAlignment = .center
//         label.text = "GS칼텍스 vs 페퍼저축은행"
        label.textColor = .black
         label.font = label.font.withSize(16)
         return label
    }()
    
    let divider1 : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let ourTeamNewsLabel : UILabel = {
        let label = UILabel()
        label.text = "우리팀 소식"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        initSubscribe()
        
    }
    
    
    private func setupView() {
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
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        scrollContentView.addSubview(todayMatchLabel)
        todayMatchLabel.translatesAutoresizingMaskIntoConstraints = false
        todayMatchLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10).isActive = true
        todayMatchLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        todayMatchLabel.topAnchor.constraint(equalTo: scrollContentView.topAnchor).isActive = true
        
        scrollContentView.addSubview(manMatchDateLabel1)
        manMatchDateLabel1.translatesAutoresizingMaskIntoConstraints = false
        manMatchDateLabel1.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        manMatchDateLabel1.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        manMatchDateLabel1.topAnchor.constraint(equalTo: todayMatchLabel.bottomAnchor,constant: 5).isActive = true
        
        scrollContentView.addSubview(manMatchPlaceLabel1)
        manMatchPlaceLabel1.translatesAutoresizingMaskIntoConstraints = false
        manMatchPlaceLabel1.leadingAnchor.constraint(equalTo: manMatchDateLabel1.leadingAnchor).isActive = true
        manMatchPlaceLabel1.trailingAnchor.constraint(equalTo: manMatchDateLabel1.trailingAnchor).isActive = true
        manMatchPlaceLabel1.topAnchor.constraint(equalTo: manMatchDateLabel1.bottomAnchor, constant: 10).isActive = true
        
        scrollContentView.addSubview(manMatchRoundLabel1)
        manMatchRoundLabel1.translatesAutoresizingMaskIntoConstraints = false
        manMatchRoundLabel1.leadingAnchor.constraint(equalTo: manMatchPlaceLabel1.leadingAnchor).isActive = true
        manMatchRoundLabel1.trailingAnchor.constraint(equalTo: manMatchPlaceLabel1.trailingAnchor).isActive = true
        manMatchRoundLabel1.topAnchor.constraint(equalTo: manMatchPlaceLabel1.bottomAnchor, constant: 5).isActive = true

        scrollContentView.addSubview(manMatchTeamLabel1)
        manMatchTeamLabel1.translatesAutoresizingMaskIntoConstraints = false
        manMatchTeamLabel1.leadingAnchor.constraint(equalTo: manMatchRoundLabel1.leadingAnchor).isActive = true
        manMatchTeamLabel1.trailingAnchor.constraint(equalTo: manMatchRoundLabel1.trailingAnchor).isActive = true
        manMatchTeamLabel1.topAnchor.constraint(equalTo: manMatchRoundLabel1.bottomAnchor, constant: 5).isActive = true
        
        scrollContentView.addSubview(womanMatchDateLabel1)
        womanMatchDateLabel1.translatesAutoresizingMaskIntoConstraints = false
        womanMatchDateLabel1.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        womanMatchDateLabel1.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanMatchDateLabel1.topAnchor.constraint(equalTo: manMatchTeamLabel1.bottomAnchor, constant: 20).isActive = true
        
        scrollContentView.addSubview(womanMatchPlaceLabel1)
        womanMatchPlaceLabel1.translatesAutoresizingMaskIntoConstraints = false
        womanMatchPlaceLabel1.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        womanMatchPlaceLabel1.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanMatchPlaceLabel1.topAnchor.constraint(equalTo: womanMatchDateLabel1.bottomAnchor, constant: 5).isActive = true
        
        
        scrollContentView.addSubview(womanMatchRoundLabel1)
        womanMatchRoundLabel1.translatesAutoresizingMaskIntoConstraints = false
        womanMatchRoundLabel1.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        womanMatchRoundLabel1.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanMatchRoundLabel1.topAnchor.constraint(equalTo: womanMatchPlaceLabel1.bottomAnchor, constant: 5).isActive = true
        
        scrollContentView.addSubview(womanMatchTeamLabel1)
        womanMatchTeamLabel1.translatesAutoresizingMaskIntoConstraints = false
        womanMatchTeamLabel1.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        womanMatchTeamLabel1.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        womanMatchTeamLabel1.topAnchor.constraint(equalTo: womanMatchRoundLabel1.bottomAnchor, constant: 5).isActive = true
        
        scrollContentView.addSubview(divider1)
        divider1.translatesAutoresizingMaskIntoConstraints = false
        divider1.heightAnchor.constraint(equalToConstant: 15).isActive = true
        divider1.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        divider1.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        divider1.topAnchor.constraint(equalTo: womanMatchTeamLabel1.bottomAnchor, constant: 10).isActive = true
        
        scrollContentView.addSubview(ourTeamNewsLabel)
        ourTeamNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        ourTeamNewsLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10).isActive = true
        ourTeamNewsLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        ourTeamNewsLabel.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 10).isActive = true
        
    }
    
    private func initSubscribe() {
        Log.debug(tag, "initSubscribe")
        
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 (E)"
        let dateString = dateFormatter.string(from: nowDate)
        
        Log.debug(tag, "dateString: \(dateString)")
        
        homeViewModel.getTodayScheduleInfo(gender: "M", dateStr: dateString).observeSingleEvent(of: .value, with: {
            snapshot in
            let value = snapshot.value as? NSDictionary
            let time = value?["time"] as? String ?? ""
            let place = value?["place"] as? String ?? ""
            let round = value?["round"] as? String ?? ""
            let hometeam = value?["home_team"] as? String ?? ""
            let awayteam = value?["away_team"] as? String ?? ""
            
            Log.debug(self.tag, "ManSchedule, time: \(time), place: \(place), hometeam: \(hometeam), awayteam: \(awayteam)")

            if value == nil {
                self.manMatchDateLabel1.text = "남자부 경기 없음"
            } else {
                self.manMatchDateLabel1.text = dateString + " " + time
                self.manMatchPlaceLabel1.text = place
                if round.contains("R") {
                    self.manMatchRoundLabel1.text = "남자부 " + round + "ound"
                } else {
                    self.manMatchRoundLabel1.text = "남자부 " + round
                }
                self.manMatchTeamLabel1.text = hometeam + " vs " + awayteam
            }
        })
        
        homeViewModel.getTodayScheduleInfo(gender: "W", dateStr: dateString).observeSingleEvent(of: .value, with: {
            snapshot in
            let value = snapshot.value as? NSDictionary
            let time = value?["time"] as? String ?? ""
            let place = value?["place"] as? String ?? ""
            let round = value?["round"] as? String ?? ""
            let hometeam = value?["home_team"] as? String ?? ""
            let awayteam = value?["away_team"] as? String ?? ""
            
            Log.debug(self.tag, "WomanSchedule, time: \(time), place: \(place), hometeam: \(hometeam), awayteam: \(awayteam)")
            
            if value == nil {
                self.womanMatchDateLabel1.text = "여자부 경기 없음"
            } else {
                self.womanMatchDateLabel1.text = dateString + " " + time
                self.womanMatchPlaceLabel1.text = place
                if round.contains("R") {
                    self.womanMatchRoundLabel1.text = "여자부 " + round + "ound"
                } else {
                    self.womanMatchRoundLabel1.text = "여자부 " + round
                }
                self.womanMatchTeamLabel1.text = hometeam + " vs " + awayteam
            }
        })
        
        
        homeViewModel.getRecentTeamNews(team: 0)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newsList in
                Log.debug(self?.tag, "newsList: \(newsList)")
                
                
            }).disposed(by: disposeBag)
    }
    
    
    
}
