//
//  UIIMageView+DownloadImage.swift
//  Core
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Service

public extension UIImageView {

    convenience init(from url: String) {
        self.init(frame: .zero)

        DefaultNetworkRepository().request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.image = UIImage(data: data)
            default:
                break
            }
        }
    }
}
