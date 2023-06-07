//
//  HomeView.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core

protocol HomeViewDelegate: AnyObject {
    func homeView(didSearchWithText text: String)
    func homeView(didSelectShow show: Show.ViewObject)
}

final class HomeView: UIView {

    weak var delegate: HomeViewDelegate?
    private var shows: [Show.ViewObject] = []

    lazy var menuView: MenuView = {
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(MenuView())

    lazy var showsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ShowCollectionCell.self, forCellWithReuseIdentifier: "show cell")
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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

    func reloadCollection(with shows: [Show.ViewObject]) {
        self.shows = shows
        showsCollection.reloadData()
    }

    func reloadItem(with id: Int) {
        showsCollection.reloadItems(at: [.init(row: id, section: 0)])
    }
}

extension HomeView: MenuViewDelegate {
    func menuView(didSearchWithText text: String) {
        delegate?.homeView(didSearchWithText: text)
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "show cell", for: indexPath) as! ShowCollectionCell
        cell.configCell(with: shows[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 180, height: 239)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeView(didSelectShow: shows[indexPath.item])
    }
}

extension HomeView: ViewCoding {

    func setupViewHierarchy() {
        addSubview(menuView)
        addSubview(showsCollection)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            menuView.widthAnchor.constraint(equalTo: widthAnchor),
            menuView.topAnchor.constraint(equalTo: topAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 80),
            menuView.centerXAnchor.constraint(equalTo: centerXAnchor),

            showsCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            showsCollection.topAnchor.constraint(equalTo: menuView.bottomAnchor),
            showsCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            showsCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
