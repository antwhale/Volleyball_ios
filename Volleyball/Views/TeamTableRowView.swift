//
//  TeamTableRowView.swift
//  Volleyball
//
//  Created by 부재식 on 2023/12/03.
//

import Foundation
import UIKit

class TeamTableRowView : UIView {
    static let tag = "TeamTableRowView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    
    let rowStackView : UIStackView = {
        let view = UIStackView()
        view.axis = NSLayoutConstraint.Axis.horizontal
        
        return view
    }()
    
    let rankLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    let teamLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    let pointLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    let matchLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    let winLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    let loseLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    let setRatioLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    let pointRatioLabel : UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 12)
        label.textAlignment = .center

        return label
    }()
    
    private func setupLayout() {
        Log.debug(TeamTableRowView.tag, "setupLayout")
        
        self.addSubview(rowStackView)
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        rowStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rowStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rowStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rowStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        rowStackView.addArrangedSubview(rankLabel)
        rowStackView.addArrangedSubview(teamLabel)
        rowStackView.addArrangedSubview(pointLabel)
        rowStackView.addArrangedSubview(matchLabel)
        rowStackView.addArrangedSubview(winLabel)
        rowStackView.addArrangedSubview(loseLabel)
        rowStackView.addArrangedSubview(setRatioLabel)
        rowStackView.addArrangedSubview(pointRatioLabel)
        
        rankLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.083).isActive = true
        teamLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.249).isActive = true
        pointLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.083).isActive = true
        matchLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.087).isActive = true
        winLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.083).isActive = true
        loseLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.083).isActive = true
        setRatioLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.166).isActive = true
        pointRatioLabel.widthAnchor.constraint(equalTo: rowStackView.widthAnchor, multiplier: 0.166).isActive = true
    
    }
    
    func putTeamRankInfo(info: TeamRankInfo) {
        rankLabel.text = String(info.rank)
        teamLabel.text = String(info.name)
        pointLabel.text = String(info.points)
        matchLabel.text = String(info.numOfMatch)
        winLabel.text = String(info.wins)
        loseLabel.text = String(info.loses)
        setRatioLabel.text = String(info.setRatio)
        pointRatioLabel.text = String(info.pointRaio)
    }
}
