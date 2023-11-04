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
    static let tag = "HomeViewController"
    private var homeViewModel = HomeViewModel()
    var clickSettingIcon : (() -> Void)?

    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .systemRed
        return scrollView
    }()
    
    let scrollContentView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemCyan
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
    
    let newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let newsTitleLabel1 : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let newsTitleLabel2 : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true

        return label
    }()
    
    let newsTitleLabel3 : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true

        return label
    }()
    
    let newsTitleLabel4 : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true

        return label
    }()
    
    let kovoMarketImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "kovomarket")
        
        return imageView
    }()
    
    let instaLabel : UILabel = {
        let label = UILabel()
        label.text = "인스타"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    let instaCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8.0
        layout.itemSize = CGSize(width: 100, height: 100)
        
        return layout
    }()
    
    lazy var instaCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.instaCollectionViewFlowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .init(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
//        collectionView.backgroundColor = .black
        collectionView.clipsToBounds = true
        collectionView.register(InstaCollectionViewCell.self, forCellWithReuseIdentifier: InstaCollectionViewCell.id)
        
        return collectionView
    }()
    
    let divider2 : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    let teamMediaLabel : UILabel = {
        let label = UILabel()
        label.text = "구단 영상"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var mediaCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width - 20, height: 150)
        
        return layout
    }()
    
    lazy var mediaCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.mediaCollectionViewFlowLayout)
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.backgroundColor = .black
        collectionView.clipsToBounds = true
        collectionView.register(NaverMediaCollectionViewCell.self, forCellWithReuseIdentifier: NaverMediaCollectionViewCell.id)

        return collectionView
    }()
    
    let mediaPageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = UIColor(named: "v9v9_color")
        
        return pageControl
    }()
    
    let divider3 : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    let cafeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cafe_banner")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(named: "v9v9_color")
        
        return imageView
    }()
    
//    lazy var cheeringTeam : Int = homeViewModel.getCheeringTeam()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        initViews()
        
        initSubscribe()
    }
    
    private func setupLayout() {
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

        scrollContentView.addSubview(todayMatchLabel)
        todayMatchLabel.translatesAutoresizingMaskIntoConstraints = false
        todayMatchLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10).isActive = true
        todayMatchLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        todayMatchLabel.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 10).isActive = true
        
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
        
        scrollContentView.addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.leadingAnchor.constraint(equalTo: ourTeamNewsLabel.leadingAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -10).isActive = true
        newsImageView.topAnchor.constraint(equalTo: ourTeamNewsLabel.bottomAnchor, constant: 10).isActive = true
        
        scrollContentView.addSubview(newsTitleLabel1)
        newsTitleLabel1.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel1.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor).isActive = true
        newsTitleLabel1.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor).isActive = true
        newsTitleLabel1.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10).isActive = true
        
        scrollContentView.addSubview(newsTitleLabel2)
        newsTitleLabel2.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel2.leadingAnchor.constraint(equalTo: newsTitleLabel1.leadingAnchor).isActive = true
        newsTitleLabel2.trailingAnchor.constraint(equalTo: newsTitleLabel1.trailingAnchor).isActive = true
        newsTitleLabel2.topAnchor.constraint(equalTo: newsTitleLabel1.bottomAnchor, constant: 15).isActive = true
        
        scrollContentView.addSubview(newsTitleLabel3)
        newsTitleLabel3.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel3.leadingAnchor.constraint(equalTo: newsTitleLabel2.leadingAnchor).isActive = true
        newsTitleLabel3.trailingAnchor.constraint(equalTo: newsTitleLabel2.trailingAnchor).isActive = true
        newsTitleLabel3.topAnchor.constraint(equalTo: newsTitleLabel2.bottomAnchor, constant: 15).isActive = true
        
        scrollContentView.addSubview(newsTitleLabel4)
        newsTitleLabel4.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel4.leadingAnchor.constraint(equalTo: newsTitleLabel3.leadingAnchor).isActive = true
        newsTitleLabel4.trailingAnchor.constraint(equalTo: newsTitleLabel3.trailingAnchor).isActive = true
        newsTitleLabel4.topAnchor.constraint(equalTo: newsTitleLabel3.bottomAnchor, constant: 15).isActive = true
        
        scrollContentView.addSubview(kovoMarketImageView)
        kovoMarketImageView.translatesAutoresizingMaskIntoConstraints = false
        kovoMarketImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        kovoMarketImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        kovoMarketImageView.topAnchor.constraint(equalTo: newsTitleLabel4.bottomAnchor, constant: 15).isActive = true
        kovoMarketImageView.backgroundColor = .black
        kovoMarketImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let kovoMarketTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self.openNewsUrl(sender:)))
        kovoMarketTap.url = "https://www.kovomarket.co.kr/"
        kovoMarketImageView.addGestureRecognizer(kovoMarketTap)
        
        scrollContentView.addSubview(instaLabel)
        instaLabel.translatesAutoresizingMaskIntoConstraints = false
        instaLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10).isActive = true
        instaLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        instaLabel.topAnchor.constraint(equalTo: kovoMarketImageView.bottomAnchor, constant: 15).isActive = true
        
        scrollContentView.addSubview(instaCollectionView)
        instaCollectionView.translatesAutoresizingMaskIntoConstraints = false
        instaCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        instaCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        instaCollectionView.topAnchor.constraint(equalTo: instaLabel.bottomAnchor, constant: 10).isActive = true
        instaCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        scrollContentView.addSubview(divider2)
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        divider2.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        divider2.topAnchor.constraint(equalTo: instaCollectionView.bottomAnchor, constant: 10).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        scrollContentView.addSubview(teamMediaLabel)
        teamMediaLabel.translatesAutoresizingMaskIntoConstraints = false
        teamMediaLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10).isActive = true
        teamMediaLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 10).isActive = true
        
        scrollContentView.addSubview(mediaCollectionView)
        mediaCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mediaCollectionView.leadingAnchor.constraint(equalTo: teamMediaLabel.leadingAnchor).isActive = true
        mediaCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -10).isActive = true
        mediaCollectionView.topAnchor.constraint(equalTo: teamMediaLabel.bottomAnchor, constant: 10).isActive = true
        mediaCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scrollContentView.addSubview(mediaPageControl)
        mediaPageControl.translatesAutoresizingMaskIntoConstraints = false
        mediaPageControl.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
        mediaPageControl.topAnchor.constraint(equalTo: mediaCollectionView.bottomAnchor, constant: 5).isActive = true
        
        scrollContentView.addSubview(divider3)
        divider3.translatesAutoresizingMaskIntoConstraints = false
        divider3.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        divider3.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        divider3.topAnchor.constraint(equalTo: mediaPageControl.bottomAnchor, constant: 10).isActive = true
        divider3.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        scrollContentView.addSubview(cafeImageView)
        cafeImageView.translatesAutoresizingMaskIntoConstraints = false
        cafeImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        cafeImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        cafeImageView.topAnchor.constraint(equalTo: divider3.bottomAnchor).isActive = true
        cafeImageView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor).isActive = true
        
        let cafeBannerTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self.openNewsUrl(sender:)))
        cafeBannerTap.url = "https://cafe.naver.com/v9v9"
        cafeImageView.addGestureRecognizer(cafeBannerTap)
        
    }
    
    private func initViews() {
        Log.debug(HomeViewController.tag, "initViews")
        
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
    
    private func initSubscribe() {
        Log.debug(HomeViewController.tag, "initSubscribe")
        
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 (E)"
        let dateString = dateFormatter.string(from: nowDate)
        
        Log.debug(HomeViewController.tag, "dateString: \(dateString)")
        
        homeViewModel.getTodayScheduleInfo(gender: "M", dateStr: dateString).observeSingleEvent(of: .value, with: {
            snapshot in
            let value = snapshot.value as? NSDictionary
            let time = value?["time"] as? String ?? ""
            let place = value?["place"] as? String ?? ""
            let round = value?["round"] as? String ?? ""
            let hometeam = value?["home_team"] as? String ?? ""
            let awayteam = value?["away_team"] as? String ?? ""
            
            Log.debug(HomeViewController.tag, "ManSchedule, time: \(time), place: \(place), hometeam: \(hometeam), awayteam: \(awayteam)")

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
            
            Log.debug(HomeViewController.tag, "WomanSchedule, time: \(time), place: \(place), hometeam: \(hometeam), awayteam: \(awayteam)")
            
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
        
        homeViewModel.instaItemSubject.subscribe(onNext: { instaArray in
            for item in instaArray {
                Log.debug(HomeViewController.tag, "instaItem link: \(item.linkUrl), img: \(item.thumbUrl)")
            }
        }).disposed(by: disposeBag)
        
        homeViewModel.instaItemSubject.asObservable()
            .bind(to: self.instaCollectionView.rx.items(cellIdentifier: "InstaCollectionViewCell", cellType: InstaCollectionViewCell.self)){ index, item, cell in
                
                Log.debug(HomeViewController.tag, "item.thumbUrl: \(item.thumbUrl), item.linkUrl: \(item.linkUrl)")
                
                guard let instaThumbUrl = URL(string: item.thumbUrl) else { return }
                cell.setThumbImage(imgUrl: instaThumbUrl)
                cell.setInstaLink(link: item.linkUrl)
                
            }.disposed(by: disposeBag)

        instaCollectionView.rx.modelSelected(MyTeamInstaItem.self)
                    .subscribe { instaItem in
                        let instaUrlID = instaItem.linkUrl.split(separator: "p/")[1].replacingOccurrences(of: "/", with: "")
                        
                        Log.debug(HomeViewController.tag, "instaUrlID: \(instaUrlID)")
                        
                        if let url = URL(string: instaItem.linkUrl) {
                            UIApplication.shared.open(url, options: [:])
                        }
                    }.disposed(by: disposeBag)
        
        
    }
    
    private func getInstaInfo() {
        let cheeringTeam = homeViewModel.getCheeringTeam()
        homeViewModel.getInstaInfo(team: cheeringTeam)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("HomeViewController viewWillAppear")
        
        getInstaInfo()
        
        mediaCollectionView.dataSource = nil
        mediaCollectionView.delegate = nil
        
        let cheeringTeam = homeViewModel.getCheeringTeam()
        homeViewModel.getNaverTvInfo(team: cheeringTeam)
            .do(onNext: {item in
                print("sos onNext")
                for data in item {
                    Log.debug("sos", "naverUrl : \(data.naverUrl), imgUrl: \(data.thumbUrl)", "\n")
                }
            })
                .do(onSubscribe: {
                    print("sos onSubscribe")
                })
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .bind(to: self.mediaCollectionView.rx.items(cellIdentifier: NaverMediaCollectionViewCell.id, cellType: NaverMediaCollectionViewCell.self)){ [weak self] index, item, cell in
                guard let naverTvThumbUrl = URL(string: item.thumbUrl) else {return}
                cell.setThumbImage(imgUrl: naverTvThumbUrl)
                cell.setNaverLink(link: "https://tv.naver.com" + item.naverUrl)
                
                let cellTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self?.openNewsUrl(sender:)))
                cellTap.url = "https://tv.naver.com" + item.naverUrl
                cell.addGestureRecognizer(cellTap)
                
            }.disposed(by: disposeBag)
        
        homeViewModel.getRecentTeamNews(team: cheeringTeam)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newsList in
                Log.debug(HomeViewController.tag, "newsList: \(newsList)")
                
                //뉴스 이미지와 타이틀 바인딩
                guard let thumbUrl = URL(string: newsList[0].thumbUrl) else { return }
                self?.newsImageView.loadImageUrl(url: thumbUrl)
                self?.newsTitleLabel1.text = newsList[0].title
                self?.newsTitleLabel2.text = newsList[1].title
                self?.newsTitleLabel3.text = newsList[2].title
                self?.newsTitleLabel4.text = newsList[3].title
                
                //클릭시 뉴스url 이동
                let firstNewsTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self?.openNewsUrl(sender:)))
                firstNewsTap.url = newsList[0].newsUrl
                self?.newsImageView.addGestureRecognizer(firstNewsTap)
                self?.newsTitleLabel1.addGestureRecognizer(firstNewsTap)
                
                let secondNewsTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self?.openNewsUrl(sender:)))
                secondNewsTap.url = newsList[1].newsUrl
                self?.newsTitleLabel2.addGestureRecognizer(secondNewsTap)
                
                let thirdNewsTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self?.openNewsUrl(sender:)))
                thirdNewsTap.url = newsList[2].newsUrl
                self?.newsTitleLabel3.addGestureRecognizer(thirdNewsTap)
                
                let fourthNewsTap = UITapGestureRecognizerWithUrl(target: self, action: #selector(self?.openNewsUrl(sender:)))
                fourthNewsTap.url = newsList[3].newsUrl
                self?.newsTitleLabel4.addGestureRecognizer(fourthNewsTap)
                
            }).disposed(by: disposeBag)
        
        self.mediaCollectionView.rx.setDelegate(self)
                    .disposed(by: disposeBag)

    }
   
    
    @objc func openNewsUrl(sender: UITapGestureRecognizerWithUrl) {
        Log.debug(HomeViewController.tag, "openNewsUrl")
        if let url = URL(string: sender.url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc func clickTest() {
        print("clickTest")
    }
}

class UITapGestureRecognizerWithUrl : UITapGestureRecognizer {
    var url: String = ""
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.mediaCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
                // CollectionView Item Size
                let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
               
                // 이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
                let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
                let index: Int
               
                // 스크롤 방향 체크
                // item 절반 사이즈 만큼 스크롤로 판단하여 올림, 내림 처리
                if velocity.x > 0 {
                   index = Int(ceil(estimatedIndex))
                } else if velocity.x < 0 {
                    index = Int(floor(estimatedIndex))
                } else {
                    index = Int(round(estimatedIndex))
                }
        
                Log.debug(HomeViewController.tag, "scrollViewWillEndDragging, index: \(index)")
        
                if index <= 0 {
                    self.mediaPageControl.currentPage = 0
                } else if index == 1 {
                    self.mediaPageControl.currentPage = index
                } else if index == 2 {
                    self.mediaPageControl.currentPage = index
                } else if index == 3 {
                    self.mediaPageControl.currentPage = index
                } else {
                    self.mediaPageControl.currentPage = 4
                }
        
               // 위 코드를 통해 페이징 될 좌표 값을 targetContentOffset에 대입
               targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}
