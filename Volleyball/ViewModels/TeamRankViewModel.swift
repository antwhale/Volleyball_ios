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
    var manTeamRankSubject = BehaviorSubject(value: String())
    let disposeBag = DisposeBag()

    func getMansRank() {
        let year = Calendar.current.component(.year, from: Date())
        guard let url = URL(string: mansTeamRankUrl + String(year)) else {return}
        
        let bakckgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        
        Completable.create { completable in
            do {
                let html = try String(String(contentsOf: url, encoding: .utf8))
                let doc : Document = try SwiftSoup.parse(html)
                let tableHTML = try doc.select(".tbl_box").first()?.html() ?? "None"
                
                Log.debug(TeamRankViewModel.tag, "tableHTML : \(tableHTML)")
                
                self.manTeamRankSubject.onNext(tableHTML)
                
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
}
