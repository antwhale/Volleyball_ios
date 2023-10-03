//
//  UIImageView+Extension.swift
//  Volleyball
//
//  Created by 부재식 on 2023/09/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
