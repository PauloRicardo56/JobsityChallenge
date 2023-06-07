//
//  DefaultShowDetailsInteractor.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//
import Service

final class DefaultShowDetailsInteractor: ShowDetailsInteractor {
    
    var presenter: ShowDetailsPresenter?
    private let repository: NetworkRepository?
    private let endpoint = "api.tvmaze.com"

    init(repository: NetworkRepository = DefaultNetworkRepository()) {
        self.repository = repository
    }

    func fetchShowDetails(with id: Int?) {
        guard let id = id else { return }
        let path = "/shows/\(id)"

        repository?.request(endpoint: endpoint, path: path, headers: [:], resultObject: ShowDetails.Response.self, completion: { [weak self] result in
            switch result {
            case .success(let showDetails):
                self?.presenter?.showDetailsPresenter(showDetails: showDetails)
            default:
                break
            }
        })
    }

    func fetchShowSeasons(with id: Int?) {
        guard let id = id else { return }
        let path = "/shows/\(id)/seasons"

        repository?.request(endpoint: endpoint, path: path, headers: [:], resultObject: [ShowSeasons.Response].self, completion: { [weak self] result in
            switch result {
            case .success(let showSeasons):
                guard let seasons = showSeasons else { return }
                let firstSeason = seasons[0].id
                self?.fetchShowEpisodes(season: firstSeason)
                self?.presenter?.showDetailsPresenter(showSeasons: seasons.map { $0.id } )
            default:
                break
            }
        })
    }

    func fetchShowEpisodes(season: Int) {
        let path = "/seasons/\(season)/episodes"

        repository?.request(endpoint: endpoint, path: path, headers: [:], resultObject: [ShowEpisodesModel.Response].self, completion: { [weak self] result in
            switch result {
            case .success(let episodes):
                guard let episodes = episodes else { return }
                var season = 0
                if !episodes.isEmpty {
                    season = episodes[2].season ?? 0
                }
                self?.presenter?.showDetailsPresenter(showEpisodes: episodes, from: season)
            default:
                break
            }
        })
    }
}
