//
//  NaverMediaCollectionViewCell.swift
//  Volleyball
//
//  Created by 부재식 on 2023/10/13.
//

import Foundation
import UIKit

class NaverMediaCollectionViewCell : UICollectionViewCell {
    static let id = "NaverMediaCollectionViewCell"
    var naverLink = ""
    
    private let thumbImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
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
        Log.debug(NaverMediaCollectionViewCell.id, "setupLayout")
        
        self.thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(thumbImageView)
        NSLayoutConstraint.activate([
              self.thumbImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
              self.thumbImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
              self.thumbImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
              self.thumbImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            ])
    }
    
    func prepare(imageUrl: String, naverUrl: String){
        if imageUrl == "" {
            self.thumbImageView.image = UIImage(named: "xmark.bin.fill")
        }
        self.naverLink = naverUrl
    }
    
    func setNaverLink(link: String) {
        self.naverLink = link
    }
    
    func setThumbImage(imgUrl: URL) {
        thumbImageView.loadImageUrl(url: imgUrl)
    }


}
