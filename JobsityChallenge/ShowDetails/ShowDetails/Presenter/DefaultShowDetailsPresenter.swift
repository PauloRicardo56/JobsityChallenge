//
//  DefaultShowDetailsPresenter.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import Core
import UIKit

final class DefaultShowDetailsPresenter: ShowDetailsPresenter {

    weak var viewController: ShowDetailsDisplay?

    func showDetailsPresenter(showDetails show: ShowDetails.Response?) {
        let summary = show?.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let detailsVO = ShowDetails.ViewObject(
            name: show?.name ?? "",
            daysAired: "\(show?.premiered ?? "") - \(show?.ended ?? "Running")",
            genres: (show?.genres ?? []).joined(separator: ", "),
            summary: summary ?? ""
        )

        viewController?.showDetailsViewController(displayShowDetails: detailsVO)
    }

    func showDetailsPresenter(showSeasons: [Int]) {
        viewController?.showDetailsViewController(displayShowSeasons: showSeasons)
    }

    func showDetailsPresenter(showEpisodes episodes: [ShowEpisodesModel.Response]?, from season: Int) {
        guard let episodes = episodes else { return }
        var season = 0
        if !episodes.isEmpty {
            season = episodes[0].season ?? 0
        }

        DispatchQueue.main.async {
            let episodesVO = episodes.map { episode in
                let image = UIImageView(from: episode.image?.medium ?? "") { [episode] in
                    let episodeNumber = episode.number ?? 0
                    self.viewController?.showDetailsViewController(reloadEpisodeNumber: episodeNumber)
                }
                let episodeVO = ShowEpisodesModel.ViewObject(image: image)
                return episodeVO
            }

            self.viewController?.showDetailsViewController(displayShowEpisodes: episodesVO, from: season)
        }
    }
}
