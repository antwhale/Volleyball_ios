//
//  NewsViewModel.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class NewsViewModel : NSObject, XMLParserDelegate {
    var newsItemsSubject = BehaviorSubject(value: [XmlNewsData]())
    
    var newsItems = [XmlNewsData]()
    var xmlDictionary: [String : String]?
    var crtElementType: String = ""
    
    let disposeBag = DisposeBag()
    
    func fetchNewsItems() {
        Log.debug("fetchNewsItems")
        
        let bakckgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        
        Completable.create { completable in
            guard let parser = XMLParser(contentsOf: URL(string: "https://thespike.co.kr/news/rss.php")!)
            else {return Disposables.create{}}
            parser.delegate = self
            parser.parse()

            completable(.completed)
            return Disposables.create{}
        }.subscribe(on: bakckgroundScheduler)
        .subscribe(onCompleted: {
            Log.debug("newsItems : \(self.newsItems)")
            self.newsItemsSubject.onNext(self.newsItems)
        }, onError: { error in
            Log.debug("fetchNewsItems error: \(error.localizedDescription)")
        }).disposed(by: disposeBag)
        
    }
    
    //XML 파싱을 시작하는 태그에서 이벤트 핸들링
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        Log.debug("parser start, elementName = \(elementName)")
        
        if elementName == "item" {
            xmlDictionary = [:]
        } else if elementName == "title" {
            crtElementType = elementName
        } else if elementName == "link" {
            crtElementType = elementName
        } else if elementName == "description" {
            crtElementType = elementName
        } else if elementName == "imgUrl" {
            crtElementType = elementName
        }
    }
    
    //태그의 Data가 string으로 들어옴
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard xmlDictionary != nil else { return }
        xmlDictionary?.updateValue(string, forKey: crtElementType)
    }
    
    //XML 파싱이 끝나는 태그에서 이벤트 핸들링
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        Log.debug("parser end, didEndElement: \(elementName)")
        guard let xmlDictionary = self.xmlDictionary else {return}
        if elementName == "item" {
            
            guard let title = xmlDictionary["title"],
                  let link = xmlDictionary["link"],
                  let description = xmlDictionary["description"]
            else {return}
            
            var imgUrl = ""
            if description.contains("img") {
                imgUrl = description.split(separator: "src=\"")[1].split(separator: "thum")[0].replacingOccurrences(of: "http", with: "https") + "thum"
            }

            let xmlNewsData = XmlNewsData(
                title: title, link: link, description: description, imgUrl: imgUrl
            )
            
            self.newsItems.append(xmlNewsData)
            self.xmlDictionary = nil
        }
        
        crtElementType = ""
    }
    
    deinit {
        Log.debug("NewViewModel deinit")
        
//        fetchNewsItemsDisposable?.disposed(by: disposeBag)
    }
    
}

