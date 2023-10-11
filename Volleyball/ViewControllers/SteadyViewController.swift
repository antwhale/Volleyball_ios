//
//  SteadyViewController.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/15.
//

import Foundation
import UIKit

class SteadyViewController: UIViewController {
    var didSendEventClosure : ((SteadyViewController.Event) -> Void)?
    
    private let steadyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Steady", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("SteadyViewController - viewDidLoad")
        view.backgroundColor = .white

        view.addSubview(steadyButton)
        steadyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            steadyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            steadyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            steadyButton.widthAnchor.constraint(equalToConstant: 200),
            steadyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        steadyButton.addTarget(self, action: #selector(didTapSteadyButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("SteadyViewController deinit")
    }
    
    @objc private func didTapSteadyButton(_ sender: Any) {
        print("SteadyButton click")
    }
}

extension SteadyViewController {
    enum Event {
        case steady
    }
}