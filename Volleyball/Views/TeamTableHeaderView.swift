//
//  TeamTableHeaderView.swift
//  Volleyball
//
//  Created by 부재식 on 2023/12/03.
//

import Foundation
import UIKit

class TeamTableHeaderView : UIView {
    static let tag = "TeamTableHeaderView"
    
    let tableHeaderStackView : UIStackView = {
        let view = UIStackView()
        view.axis = NSLayoutConstraint.Axis.horizontal
        view.backgroundColor = UIColor(named: "v9v9_color")
        
        return view
    }()
    
    let rankHeader : UILabel = {
        let label = UILabel()
        label.text = "순위"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white
        
        return label
    }()
    
    let teamNameHeader : UILabel = {
        let label = UILabel()
        label.text = "팀명"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    let pointHeader : UILabel = {
        let label = UILabel()
        label.text = "승점"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    let matchNumHeader : UILabel = {
        let label = UILabel()
        label.text = "경기수"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    let winHeader : UILabel = {
        let label = UILabel()
        label.text = "승"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    let loseHeader : UILabel = {
        let label = UILabel()
        label.text = "패"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    let setRatioHeader : UILabel = {
        let label = UILabel()
        label.text = "세트득실률"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    let pointRatioHeader : UILabel = {
        let label = UILabel()
        label.text = "점수득실률"
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = .white

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        Log.debug(TeamTableHeaderView.tag, "setupLayout")
        
//        view.addSubview(tableHeaderStackView)
        
        self.addSubview(tableHeaderStackView)
        tableHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableHeaderStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableHeaderStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableHeaderStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        tableHeaderStackView.addArrangedSubview(rankHeader)
        tableHeaderStackView.addArrangedSubview(teamNameHeader)
        tableHeaderStackView.addArrangedSubview(pointHeader)
        tableHeaderStackView.addArrangedSubview(matchNumHeader)
        tableHeaderStackView.addArrangedSubview(winHeader)
        tableHeaderStackView.addArrangedSubview(loseHeader)
        tableHeaderStackView.addArrangedSubview(setRatioHeader)
        tableHeaderStackView.addArrangedSubview(pointRatioHeader)
        
        rankHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.083).isActive = true
        teamNameHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.249).isActive = true
        pointHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.083).isActive = true
        matchNumHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.087).isActive = true
        winHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.083).isActive = true
        loseHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.083).isActive = true
        setRatioHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.166).isActive = true
        pointRatioHeader.widthAnchor.constraint(equalTo: tableHeaderStackView.widthAnchor, multiplier: 0.166).isActive = true
    }
}
