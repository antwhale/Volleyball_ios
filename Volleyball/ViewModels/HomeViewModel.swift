//
//  HomeViewModel.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import RxSwift
import SwiftSoup

class HomeViewModel {
    let tag = "HomeViewModel"
    let ref = Database.database().reference()
    
    let instaItemSubject = PublishSubject<[MyTeamInstaItem]>()
    let disposeBag = DisposeBag()
    
    let teamList = [
        //여자배구
        TeamInfo(team_youtube: "gsvolleyball", team_insta: "gscaltexkixx", team_news: "gs%EC%B9%BC%ED%85%8D%EC%8A%A4"),
        TeamInfo(team_youtube: "ibkaltos", team_insta: "ibk__altos", team_news: "%EA%B8%B0%EC%97%85%EC%9D%80%ED%96%89"),
        TeamInfo(team_youtube: "hipassvolleyclub", team_insta: "hipassvolleyclub", team_news: "%EB%8F%84%EB%A1%9C%EA%B3%B5%EC%82%AC"),
        TeamInfo(team_youtube: "kgcvolley", team_insta: "red__sparks", team_news: "%ec%a0%95%ea%b4%80%ec%9e%a5%0d%0a"),
        TeamInfo(team_youtube: "aipeppers", team_insta: "aipeppers", team_news: "%ED%8E%98%ED%8D%BC%EC%A0%80%EC%B6%95%EC%9D%80%ED%96%89"),
        TeamInfo(team_youtube: "hdecvolleyball", team_insta: "hdecvolleyball", team_news: "%ED%98%84%EB%8C%80%EA%B1%B4%EC%84%A4"),
        TeamInfo(team_youtube: "pinkspiders", team_insta: "hkpinkspiders", team_news: "%ED%9D%A5%EA%B5%AD%EC%83%9D%EB%AA%85"),
        //남자배구
        TeamInfo(team_youtube: "kbstarsvc", team_insta: "kbstarsvc", team_news: "kb%EC%86%90%ED%95%B4%EB%B3%B4%ED%97%98"),
        TeamInfo(team_youtube: "okfinancialgroupvc", team_insta: "okman_volleyballclub", team_news: "OK%EA%B8%88%EC%9C%B5%EA%B7%B8%EB%A3%B9"),
        TeamInfo(team_youtube: "kaljumbos", team_insta: "kal_jbos", team_news: "%EB%8C%80%ED%95%9C%ED%95%AD%EA%B3%B5"),
        TeamInfo(team_youtube: "bluefangsvc", team_insta: "bluefangsvc", team_news: "%EC%82%BC%EC%84%B1%ED%99%94%EC%9E%AC"),
        TeamInfo(team_youtube: "wooricardwooriwon", team_insta: "wooricardwibee", team_news: "%EC%9A%B0%EB%A6%AC%EC%B9%B4%EB%93%9C"),
        TeamInfo(team_youtube: "kepcovolleyball", team_insta: "vixtorm_vbc", team_news: "%ED%95%9C%EA%B5%AD%EC%A0%84%EB%A0%A5"),
        TeamInfo(team_youtube: "skywalkers", team_insta: "skywalkers_vbc", team_news: "%ED%98%84%EB%8C%80%EC%BA%90%ED%94%BC%ED%83%88"),
        TeamInfo(team_youtube: "kovo", team_insta: "kovopr_official", team_news: "%EB%B0%B0%EA%B5%AC")
    ]
    
    func getTodayScheduleInfo(gender : String, dateStr : String) -> DatabaseReference {
        
        if(gender == "M") {
            return ref.child("ManSchedule").child(dateStr)
        } else {
            return ref.child("WomanSchedule").child(dateStr)
        }
    }
    
    func getRecentTeamNews(team: Int) -> Observable<Array<MyTeamNewsItem>> {
        return Observable.create { observer in
            let newsUrl = "https://thespike.co.kr/news/search.php?q=" + self.teamList[team].team_news + "&x=0&y=0"
            guard let url = URL(string: newsUrl) else { return Disposables.create() }
            
            do {
                var newsItemList : Array<MyTeamNewsItem> = []
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                let elements = try doc.select("div#listWrap").select("div.listPhoto")
                
                for i in 0...3 {
                    let newsUrl = try elements.select("p.img a").get(i).attr("href")
                    let imgUrl = try elements.select("img").get(i).attr("src")
                    let title = try elements.select("dt a").get(i).text()
                    
                    Log.debug(self.tag, "newsUrl: \(newsUrl), imgUrl: \(imgUrl), title: \(title)")
                    
                    newsItemList.append(MyTeamNewsItem(thumbUrl: "https://thespike.co.kr" + imgUrl, newsUrl: "https://thespike.co.kr" + newsUrl, title: title))
                }
                
                observer.onNext(newsItemList)
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create {}
        }
    }
    
    func getInstaInfo(team: Int) {
        return ref.child("Insta")
            .child(intToTeam(team: team))
            .observeSingleEvent(of: .value, with: { [weak self] snapshot in
                let value = snapshot.value as? NSArray
                            
                var instaArray: [MyTeamInstaItem] = []
                for i in 0...4 {
                    if let instaLink = (value?[i] as? NSDictionary)?["link"] as? String,
                       let instaImgUrl = (value?[i] as? NSDictionary)?["imgUrl"] as? String {
                        instaArray.append(MyTeamInstaItem(thumbUrl: instaImgUrl, linkUrl: instaLink))
                    }
                }
                self?.instaItemSubject.onNext(instaArray)
            })
    }
    
    func getNaverTvInfo(team: Int) -> Observable<[SliderItem]> {
        Log.debug(tag, "getNaverTvInfo")
        
        return Observable.create { observer in
            
            guard let naverTvUrl = URL(string: "https://tv.naver.com/" + self.teamList[team].team_youtube) else {return Disposables.create()}
            
            do {
                var sliderItemList : [SliderItem] = []
                let html = try String(contentsOf: naverTvUrl, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                let elements = try doc.select("div[class=cds _MM_CARD  ]")
                
                for i in 0...4 {
                    let naverUrl = try elements.get(i).select("div.cds_type a.cds_thm").attr("href")
                    let imgUrl = try elements.get(i).select("img").attr("src")
                    
                    sliderItemList.append(SliderItem(thumbUrl: imgUrl, naverUrl: naverUrl))
                }
                
                observer.onNext(sliderItemList)

            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create {}
        }
    }
    
    func getCheeringTeam() -> Int {
        return UserDefaults.standard.integer(forKey: "MyTeam")
    }
    
    
    
    private func intToTeam(team: Int) -> String{
        switch team {
        case 0:
            return "GS"
        case 1:
            return "IBK"
        case 2:
            return "Hypass"
        case 3:
            return "KGC"
        case 4:
            return "Pepper"
        case 5:
            return "Hillstate"
        case 6:
            return "PinkSpiders"
        case 7:
            return "KB"
        case 8:
            return "OK"
        case 9:
            return "Jumbos"
        case 10:
            return "Samsung"
        case 11:
            return "Woori"
        case 12:
            return "Kepco"
        case 13:
            return "SkyWalkers"
        case 14:
            return "KOVO"
        default:
            return "KOVO"
        }
    }
}

struct MyTeamNewsItem {
    let thumbUrl: String
    let newsUrl: String
    let title: String
}

struct MyTeamInstaItem {
    let thumbUrl: String
    let linkUrl: String
}

struct SliderItem {
    let thumbUrl : String
    let naverUrl : String
}




