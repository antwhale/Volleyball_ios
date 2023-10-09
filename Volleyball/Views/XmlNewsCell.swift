//
//  XmlNewsCell.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/23.
//

import Foundation
import UIKit

class XmlNewsCell : UITableViewCell {
    static let reuseIdentifier = "XmlNewsCell"
    
    private let newsTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    private let newsThumbImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        Log.debug(reuseIdentifier!, "setupLayout")
        
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        
        contentView.addSubview(newsThumbImageView)
        newsThumbImageView.translatesAutoresizingMaskIntoConstraints = false
        newsThumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        newsThumbImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        newsThumbImageView.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 8).isActive = true
        newsThumbImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
    }
    
    func setTitle(newsTitle: String) {
        newsTitleLabel.text = newsTitle
    }
    
    func setThumbnail(imgUrl: URL) {
        newsThumbImageView.loadImageUrl(url: imgUrl)
    }
    
}
