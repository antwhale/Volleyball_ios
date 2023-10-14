//
//  InstaCollectionViewCell.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/08.
//

import Foundation
import UIKit

class InstaCollectionViewCell : UICollectionViewCell {
    static let id = "InstaCollectionViewCell"
    var instaLink = ""
    
    private let thumbImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }
    
    private func setupLayout() {
        Log.debug(InstaCollectionViewCell.id, "setupLayout")
        
        self.thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(thumbImageView)
        NSLayoutConstraint.activate([
              self.thumbImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
              self.thumbImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
              self.thumbImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
              self.thumbImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            ])    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        self.prepare(imageUrl: "", instaUrl: "")
//    }
    
    func prepare(imageUrl: String, instaUrl: String){
        if imageUrl == "" {
            self.thumbImageView.image = UIImage(named: "xmark.bin.fill")
        }
        self.instaLink = instaUrl
    }
    
    func setInstaLink(link: String) {
        self.instaLink = link
    }
    
    func setThumbImage(imgUrl: URL) {
        thumbImageView.loadImageUrl(url: imgUrl)
    }
    
}
