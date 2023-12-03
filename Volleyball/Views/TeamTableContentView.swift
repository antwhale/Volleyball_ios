//
//  TeamTableContentView.swift
//  Volleyball
//
//  Created by 부재식 on 2023/12/03.
//

import Foundation
import UIKit

class TeamTableContentView : UIView {
    static let tag = "TeamTableContentView"
    
    let rowStackView : UIStackView = {
        let view = UIStackView()
        view.axis = NSLayoutConstraint.Axis.vertical
        view.distribution = .equalSpacing
        view.spacing = 5
        
        return view
    }()
    
    let teamTableRowView1 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
    }()
    
    let teamTableRowView2 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
    }()
    
    let teamTableRowView3 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
    }()
    
    let teamTableRowView4 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
    }()
    
    let teamTableRowView5 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
    }()
    
    let teamTableRowView6 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
    }()
    
    let teamTableRowView7 : TeamTableRowView = {
        let view = TeamTableRowView()
        return view
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
        Log.debug(TeamTableContentView.tag, "setupLayout")
        
        self.addSubview(rowStackView)
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        rowStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rowStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rowStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rowStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        rowStackView.addArrangedSubview(teamTableRowView1)
        rowStackView.addArrangedSubview(teamTableRowView2)
        rowStackView.addArrangedSubview(teamTableRowView3)
        rowStackView.addArrangedSubview(teamTableRowView4)
        rowStackView.addArrangedSubview(teamTableRowView5)
        rowStackView.addArrangedSubview(teamTableRowView6)
        rowStackView.addArrangedSubview(teamTableRowView7)
    }
    
    func setContent(contents: [TeamRankInfo]) {
        for (n, info) in contents.enumerated() {
            switch n {
            case 0:
                teamTableRowView1.putTeamRankInfo(info: info)
            case 1:
                teamTableRowView2.putTeamRankInfo(info: info)
            case 2:
                teamTableRowView3.putTeamRankInfo(info: info)
            case 3:
                teamTableRowView4.putTeamRankInfo(info: info)
            case 4:
                teamTableRowView5.putTeamRankInfo(info: info)
            case 5:
                teamTableRowView6.putTeamRankInfo(info: info)
            case 6:
                teamTableRowView7.putTeamRankInfo(info: info)
            default:
                Log.error(TeamTableContentView.tag, "THIS IS UNKNOWN RANK INFO")
            }
        }
    }
}
