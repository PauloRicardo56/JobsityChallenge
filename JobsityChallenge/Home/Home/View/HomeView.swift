//
//  HomeView.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core

final class HomeView: UIView {

    lazy var menuView: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .gray
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeView: ViewCoding {

    func setupViewHierarchy() {
        addSubview(menuView)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            menuView.widthAnchor.constraint(equalTo: widthAnchor),
            menuView.topAnchor.constraint(equalTo: topAnchor),
            menuView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            menuView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
