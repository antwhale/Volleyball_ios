//
//  TeamRankViewModel.swift
//  Volleyball
//
//  Created by 부재식 on 2023/11/19.
//

import Foundation
import SwiftSoup
import RxSwift
import RxCocoa
import RxRelay

class TeamRankViewModel {
    static let tag = "TeamRankViewModel"
    
    let mansTeamRankUrl = "https://sports.news.naver.com/volleyball/record/index?category=kovo&year="
    let womansTeamRankUrl = "https://sports.news.naver.com/volleyball/record/index?category=wkovo&year="
    var manTeamRankSubject = BehaviorSubject(value: [TeamRankInfo]())
    var womanTeamRankSubject = BehaviorSubject(value: [TeamRankInfo]())
    let disposeBag = DisposeBag()

    func getMansRank() {
        let year = Calendar.current.component(.year, from: Date())
        guard let url = URL(string: mansTeamRankUrl + String(year)) else {return}
        
        let bakckgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        
        Completable.create { completable in
            do {
                let html = try String(String(contentsOf: url, encoding: .utf8))
                let doc : Document = try SwiftSoup.parse(html)
                let tableHTML = try doc.select(".tbl_box").first()
                let rows = try tableHTML?.select("#regularTeamRecordList_table > tr")           //행 7개

                guard let rows else {return Disposables.create()}

                var teamRankInfos = [TeamRankInfo]()

                for info in rows {
                    let rank = try info.select("th").text()
                    let teamName = try info.select("td").get(0).text()
                    let matches = try info.select("td").get(1).text()
                    let points = try info.select("td").get(2).text()
                    let wins = try info.select("td").get(3).text()
                    let loses = try info.select("td").get(4).text()
                    let setRatio = try info.select("td").get(5).text()
                    let pointRatio = try info.select("td").get(6).text()
//                    Log.debug(TeamRankViewModel.tag, "rank: \(rank), teamName: \(teamName), matches: \(matches), points: \(points), wins: \(wins), loses: \(loses), setRatio: \(setRatio),  pointRaio: \(pointRatio)")
                    
                    teamRankInfos.append(
                        TeamRankInfo(rank: Int(rank) ?? 0,
                                    name: teamName,
                                     points: Int(points) ?? 0,
                                     numOfMatch: Int(matches) ?? 0,
                                     wins: Int(wins) ?? 0,
                                     loses: Int(loses) ?? 0,
                                     setRatio: Float(setRatio) ?? 0.0,
                                     pointRaio: Float(pointRatio) ?? 0.0)
                    )
                    
                    continue
                }
                
                Log.debug(TeamRankViewModel.tag, "getMansRank, teamRankInfos: \(teamRankInfos)")
                
                self.manTeamRankSubject.onNext(teamRankInfos)
                
            } catch let error {
                Log.error(TeamRankViewModel.tag, error.localizedDescription)
            }

            completable(.completed)
            return Disposables.create{}
        }.subscribe(on: bakckgroundScheduler)
        .subscribe(onCompleted: {
            Log.debug("getMansRank onCompleted")
//            self.newsItemsSubject.onNext(self.newsItems)
        }, onError: { error in
            Log.error(TeamRankViewModel.tag, "fetchNewsItems error: \(error.localizedDescription)")
        }).disposed(by: disposeBag)
    }
    
    func getWomansRank() {
        let year = Calendar.current.component(.year, from: Date())
        guard let url = URL(string: womansTeamRankUrl + String(year)) else {return}
        
        let bakckgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        
        Completable.create { completable in
            do {
                let html = try String(String(contentsOf: url, encoding: .utf8))
                let doc : Document = try SwiftSoup.parse(html)
                let tableHTML = try doc.select(".tbl_box").first()
                let rows = try tableHTML?.select("#regularTeamRecordList_table > tr")           //행 7개

                guard let rows else {return Disposables.create()}

                var teamRankInfos = [TeamRankInfo]()

                for info in rows {
                    let rank = try info.select("th").text()
                    let teamName = try info.select("td").get(0).text()
                    let matches = try info.select("td").get(1).text()
                    let points = try info.select("td").get(2).text()
                    let wins = try info.select("td").get(3).text()
                    let loses = try info.select("td").get(4).text()
                    let setRatio = try info.select("td").get(5).text()
                    let pointRatio = try info.select("td").get(6).text()
//                    Log.debug(TeamRankViewModel.tag, "rank: \(rank), teamName: \(teamName), matches: \(matches), points: \(points), wins: \(wins), loses: \(loses), setRatio: \(setRatio),  pointRaio: \(pointRatio)")
                    
                    teamRankInfos.append(
                        TeamRankInfo(rank: Int(rank) ?? 0,
                                    name: teamName,
                                     points: Int(points) ?? 0,
                                     numOfMatch: Int(matches) ?? 0,
                                     wins: Int(wins) ?? 0,
                                     loses: Int(loses) ?? 0,
                                     setRatio: Float(setRatio) ?? 0.0,
                                     pointRaio: Float(pointRatio) ?? 0.0)
                    )
                    
                    continue
                }
                
                Log.debug(TeamRankViewModel.tag, "getWomansRank, teamRankInfos: \(teamRankInfos)")
                
                self.womanTeamRankSubject.onNext(teamRankInfos)
                
            } catch let error {
                Log.error(TeamRankViewModel.tag, error.localizedDescription)
            }

            completable(.completed)
            return Disposables.create{}
        }.subscribe(on: bakckgroundScheduler)
        .subscribe(onCompleted: {
            Log.debug("getWomansRank onCompleted")
//            self.newsItemsSubject.onNext(self.newsItems)
        }, onError: { error in
            Log.error(TeamRankViewModel.tag, "fetchNewsItems error: \(error.localizedDescription)")
        }).disposed(by: disposeBag)
    }
    
    
}
