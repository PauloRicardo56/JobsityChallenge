//
//  MenuView.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core

protocol MenuViewDelegate: AnyObject {
    func menuView(didSearchWithText text: String)
}

final class MenuView: UIView {

    weak var delegate: MenuViewDelegate?

    lazy var mainStackView: UIStackView = {
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    lazy var homeButton: UIButton = {
        $0.setTitle("Home", for: .normal)
        return $0
    }(UIButton())

    lazy var searchButton: UIButton = {
        $0.setTitle("Search", for: .normal)
        $0.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return $0
    }(UIButton())

    lazy var searchBar: UISearchBar = {
        $0.searchBarStyle = .minimal
        $0.backgroundColor = .black
        $0.tintColor = .white
        $0.searchTextField.textColor = .white
        $0.showsCancelButton = true
        $0.delegate = self
//        $0.isHidden = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UISearchBar())

    init() {
        super.init(frame: .zero)

        backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
