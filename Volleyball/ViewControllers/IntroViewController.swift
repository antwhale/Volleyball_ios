//
//  IntroViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/16.
//

import Foundation
import UIKit

class IntroViewController: UIViewController {
    var didSendEventClosure : ((IntroViewController.Event) -> Void)?
    
    private let imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "v9v9_icon")
         
         return imageView
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("IntroViewController - viewDidLoad")
        
        view.backgroundColor = UIColor(named: "v9v9_color")
        view.addSubview(imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Log.debug("Intro pass 1.5 sec")
            
            self.didSendEventClosure?(.next)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.imageView.center = view.center
    }
}

extension IntroViewController {
    enum Event {
        case next
    }
}

