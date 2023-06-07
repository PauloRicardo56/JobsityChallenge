//
//  SeasonEpisodesCollectionViewCell.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit
import Core

final class SeasonEpisodesCollectionViewCell: UICollectionViewCell {

    private var episodes = [ShowEpisodesModel.ViewObject]()

    lazy var episodesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SingleEpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "single episode cell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func config(with episodes: [ShowEpisodesModel.ViewObject]) {
        self.episodes = episodes
        episodesCollection.reloadData()
        setupView()
    }
}

extension SeasonEpisodesCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "single episode cell", for: indexPath) as! SingleEpisodesCollectionViewCell
        cell.config(with: episodes[indexPath.item].image.image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 250, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.homeView(didSelectShow: shows[indexPath.item])
    }
}

extension SeasonEpisodesCollectionViewCell: ViewCoding {

    func setupViewHierarchy() {
        addSubview(episodesCollection)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            episodesCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            episodesCollection.topAnchor.constraint(equalTo: topAnchor),
            episodesCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            episodesCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
