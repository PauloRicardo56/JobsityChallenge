//
//  ShowDetailsCoordinator.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit
import Core
import EpisodeDetails

public final class ShowDetailsCoordinator: Coordinator {

    public let rootViewController: UINavigationController
    public var showId: Int?
    public var showImage: UIImage?

    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    public func start(completion: (() -> Void)? = nil) {
        let controller = ShowDetailsViewController()
        let interactor = DefaultShowDetailsInteractor()
        let presenter = DefaultShowDetailsPresenter()
        controller.coordinator = self
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller

        rootViewController.pushViewController(controller, animated: true)
    }

    func showEpisodeDetails(episode: ShowEpisodesModel.ViewObject) {
        let episodeDetailsVO = EpisodeDetailsModel.ViewObject(
            image: episode.image,
            name: episode.name,
            episodeAndSeasonNumber: episode.episodeAndSeasonNumber,
            summary: episode.summary)
        let episodeDetailsCoordinator = EpisodeDetailsCoordinator(rootViewController: rootViewController)
        episodeDetailsCoordinator.episode = episodeDetailsVO
        episodeDetailsCoordinator.start()
    }
}
