//
//  SingleEpisodesCollectionViewCell.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit
import Core

final class SingleEpisodesCollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = { view in
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIImageView())

    func config(with image: UIImage?) {
        setupView()
        imageView.image = image
        backgroundColor = .gray
    }

    func config() {
        setupView()
        backgroundColor = .green
    }
}

extension SingleEpisodesCollectionViewCell: ViewCoding {

    func setupViewHierarchy() {
        addSubview(imageView)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
