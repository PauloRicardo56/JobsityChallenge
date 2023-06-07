//
//  MenuView.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core

protocol MenuViewDelegate: AnyObject {
    func menuView(didTapHome view: MenuView)
    func menuView(didSearchWithText text: String)
}

final class MenuView: UIView {

    weak var delegate: MenuViewDelegate?

    lazy var mainStackView: UIStackView = { view in
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIStackView())

    lazy var homeButton: UIButton = { button in
        button.setTitle("Home", for: .normal)
        button.addTarget(self, action: #selector(didTapHome), for: .touchUpInside)
        return button
    }(UIButton())

    lazy var searchButton: UIButton = { button in
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return button
    }(UIButton())

    lazy var searchBar: UISearchBar = { bar in
        bar.searchBarStyle = .minimal
        bar.backgroundColor = .black
        bar.tintColor = .white
        bar.searchTextField.textColor = .white
        bar.showsCancelButton = true
        bar.delegate = self
        bar.isHidden = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }(UISearchBar())

    init() {
        super.init(frame: .zero)

        backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapHome() {
        delegate?.menuView(didTapHome: self)
    }

    @objc func didTapSearch() {
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
    }
}

extension MenuView: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideSearch()
        delegate?.menuView(didSearchWithText: searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearch()
        searchBar.text = ""
    }

    private func hideSearch() {
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
    }
}

extension MenuView: ViewCoding {

    func setupViewHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(homeButton)
        mainStackView.addArrangedSubview(searchButton)
        addSubview(searchBar)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([

            mainStackView.heightAnchor.constraint(equalToConstant: 30),
            mainStackView.widthAnchor.constraint(equalTo: widthAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor)
        ])
    }
}
