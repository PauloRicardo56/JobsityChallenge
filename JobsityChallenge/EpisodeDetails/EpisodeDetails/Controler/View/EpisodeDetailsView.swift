//
//  EpisodeDetailsView.swift
//  EpisodeDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import Core
import UIKit

protocol EpisodeDetailsViewDelegate: AnyObject {

}

final class EpisodeDetailsView: UIView {

    lazy var scrollView: UIScrollView = { view in
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIScrollView())

    lazy var imageView: UIImageView = { image in
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }(UIImageView())

    lazy var name: UILabel = { label in
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 44, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var episodeAndSeason: UILabel = { label in
        label.textColor = .white
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var summary: UILabel = { label in
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(with episode: EpisodeDetailsModel.ViewObject?) {
        imageView.image = episode?.image.image
        name.text = episode?.name
        episodeAndSeason.text = episode?.episodeAndSeasonNumber
        summary.text = episode?.summary
    }
}

extension EpisodeDetailsView: ViewCoding {
    func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(name)
        scrollView.addSubview(episodeAndSeason)
        scrollView.addSubview(summary)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75),

            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            name.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            episodeAndSeason.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeAndSeason.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),

            summary.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            summary.topAnchor.constraint(equalTo: episodeAndSeason.bottomAnchor, constant: 25),
            summary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            summary.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25)
        ])
    }
}
