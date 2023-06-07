//
//  EpisodesCollectionHeaderView.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit
import Core

final class EpisodesCollectionHeaderView: UICollectionReusableView {

    lazy var titleLabel: UILabel = { label in
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    func configWith(title: String) {
        setupView()
        titleLabel.text = title
    }
}

extension EpisodesCollectionHeaderView: ViewCoding {

    func setupViewHierarchy() {
        addSubview(titleLabel)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        ])
    }
}
