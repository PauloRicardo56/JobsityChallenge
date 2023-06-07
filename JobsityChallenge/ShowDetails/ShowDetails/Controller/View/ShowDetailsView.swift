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
    private var seasonsEpisodes = [[ShowEpisodesModel.ViewObject]]()

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

    lazy var episodesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = .init(width: 10, height: 50)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SeasonEpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "episodes cell")
        view.register(EpisodesCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
        showSeasons.forEach { _ in seasonsEpisodes.append([]) }
        episodesCollection.reloadData()
    }

    func configEpisodesOfASeason(season: Int, episodes: [ShowEpisodesModel.ViewObject]) {
        seasonsEpisodes.insert(episodes, at: max(0, season - 1))
    }

    func reloadEpisode(season: Int, episode: Int) {
        episodesCollection.reloadItems(at: [.init(item: episode - 1, section: season - 1)])
    }
}

extension ShowDetailsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        showSeasons.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodes cell", for: indexPath) as! SeasonEpisodesCollectionViewCell
        cell.config(with: seasonsEpisodes[indexPath.section])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: scrollView.frame.width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.homeView(didSelectShow: shows[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! EpisodesCollectionHeaderView
        cell.configWith(title: "Season \(indexPath.section + 1)")
        return cell
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
            episodesCollection.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 30),
            episodesCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            episodesCollection.heightAnchor.constraint(equalToConstant: 4 * (50 + 150)),
            episodesCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
        ])
    }
}
