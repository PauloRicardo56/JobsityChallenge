//
//  ShowDetailsViewController.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit

protocol ShowDetailsDisplay: AnyObject {
    func showDetailsViewController(displayShowDetails show: ShowDetails.ViewObject)
    func showDetailsViewController(displayShowSeasons seasons: [Int])
    func showDetailsViewController(displayShowEpisodes episodes: [ShowEpisodesModel.ViewObject], from season: Int)
    func showDetailsViewController(reloadEpisodeNumber number: Int)
}

final class ShowDetailsViewController: UIViewController {

    var interactor: ShowDetailsInteractor?
    var coordinator: ShowDetailsCoordinator?

    lazy var showDetailsView: ShowDetailsView = { view in
        view.delegate = self
        return view
    }(ShowDetailsView())

    override func loadView() {
        super.loadView()
        view = showDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)

        let image = coordinator?.showImage
        let showId = coordinator?.showId
        showDetailsView.configView(with: image)
        interactor?.fetchShowDetails(with: showId)
        interactor?.fetchShowSeasons(with: showId)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension ShowDetailsViewController: ShowDetailsViewDelegate {

    func showDetailsView(didSelectSeason seasonId: Int) {
        interactor?.fetchShowEpisodes(season: seasonId)
    }
}

extension ShowDetailsViewController: ShowDetailsDisplay {

    func showDetailsViewController(displayShowDetails show: ShowDetails.ViewObject) {
        DispatchQueue.main.async {
            self.showDetailsView.configView(with: show)
        }
    }

    func showDetailsViewController(displayShowSeasons seasons: [Int]) {
        DispatchQueue.main.async {
            self.showDetailsView.configEpisodesCollection(with: seasons)
        }
    }

    func showDetailsViewController(displayShowEpisodes episodes: [ShowEpisodesModel.ViewObject], from season: Int) {
        DispatchQueue.main.async {
            self.showDetailsView.configEpisodesOfASeason(season: season, episodes: episodes)
        }
    }

    func showDetailsViewController(reloadEpisodeNumber number: Int) {
        DispatchQueue.main.async {
            self.showDetailsView.reloadEpisode(episode: number)
        }
    }
}
