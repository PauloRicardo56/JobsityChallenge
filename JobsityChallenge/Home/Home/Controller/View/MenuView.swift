//
//  MenuView.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core

final class MenuView: UIView {

    lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home", for: .normal)
        return button
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView: ViewCoding {

    func setupViewHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(homeButton)
        mainStackView.addArrangedSubview(searchButton)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: widthAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
