//
//  GoViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/15.
//

import Foundation
import UIKit

class GoViewController: UIViewController {
    var didSendEventClosure : ((GoViewController.Event) -> Void)?

    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("GoViewController viewDidLoad")
        
    }
}

extension GoViewController {
    enum Event {
        case go
    }
}
