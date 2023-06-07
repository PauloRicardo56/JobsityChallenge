//
//  EpisodeDetailsViewController.swift
//  EpisodeDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit

final class EpisodeDetailsViewController: UIViewController {

    var coordinator: EpisodeDetailsCoordinator?

    lazy var episodeDetailsView: EpisodeDetailsView = { view in
        view
    }(EpisodeDetailsView())

    override func loadView() {
        super.loadView()

        view = episodeDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        episodeDetailsView.config(with: coordinator?.episode)
    }
}
