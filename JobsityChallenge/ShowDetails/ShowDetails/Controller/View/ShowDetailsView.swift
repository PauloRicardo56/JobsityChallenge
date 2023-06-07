//
//  ShowDetailsView.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import Core
import UIKit

final class ShowDetailsView: UIView {

    private var showSeasons = [Int]()
    private var episodes = [ShowEpisodesModel.ViewObject]()

    lazy var scrollView: UIScrollView = { view in
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIScrollView())

    lazy var imageView: UIImageView = { view in
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIImageView())

    lazy var airedLabel: UILabel = { label in
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var genresLabel: UILabel = { label in
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var summaryLabel: UILabel = { label in
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var selectSeasonButton: UIButton = { button in
        button.backgroundColor = .gray
        return button
    }(UIButton())

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

    init() {
        super.init(frame: .zero)

        backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configView(with image: UIImage?) {
        imageView.image = image
    }

    func configView(with details: ShowDetails.ViewObject) {
        airedLabel.text = details.daysAired
        genresLabel.text = details.genres
        summaryLabel.text = details.summary
    }

    func configEpisodesCollection(with showSeasons: [Int]) {
        self.showSeasons = showSeasons
        episodesCollection.reloadData()
    }

    func configEpisodesOfASeason(season: Int, episodes: [ShowEpisodesModel.ViewObject]) {
        self.episodes = episodes
        episodesCollection.reloadData()
    }

    func reloadEpisode(episode: Int) {
        episodesCollection.reloadItems(at: [.init(item: episode-1, section: 0)])
    }
}

extension ShowDetailsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

extension ShowDetailsView: ViewCoding {
    func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(airedLabel)
        scrollView.addSubview(genresLabel)
        scrollView.addSubview(summaryLabel)
        scrollView.addSubview(episodesCollection)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 159),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            airedLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            airedLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            airedLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),

            genresLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            genresLabel.topAnchor.constraint(equalTo: airedLabel.bottomAnchor, constant: 8),
            genresLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),

            summaryLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            episodesCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            episodesCollection.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 80),
            episodesCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            episodesCollection.heightAnchor.constraint(equalToConstant: 150),
            episodesCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
        ])
    }
}
