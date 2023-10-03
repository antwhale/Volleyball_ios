//
//  ReadyViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/15.
//

import Foundation
import UIKit

class ReadyViewController: UIViewController {
    var didSendEventClosure : ((ReadyViewController.Event) -> Void)?

    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ready", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("ReadyViewController viewDidLoad")
        view.backgroundColor = .white
        
        view.addSubview(readyButton)
        readyButton
            .translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            readyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            readyButton.widthAnchor.constraint(equalToConstant: 200),
            readyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        readyButton.addTarget(self, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapReadyButton(_ sender: Any) {
        print("ReadyButton click")
    }
    
}

extension ReadyViewController {
    enum Event {
        case ready
    }
}
