//
//  DefaultHomeInteractor.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import Service

final class DefaultHomeInteractor: HomeInteractor {

    var presenter: HomePresenter?
    private let repository: NetworkRepository?
    private let endpoint = "api.tvmaze.com"

    init(repository: NetworkRepository = DefaultNetworkRepository()) {
        self.repository = repository
    }

    func fetchShows() {
        let path = "/shows"

        repository?.request(endpoint: endpoint, path: path, resultObject: [Show.Response].self, completion: { [weak self] result in
            switch result {
            case .success(let shows):
                self?.presenter?.present(shows: shows)
            default:
                break
            }
        })
    }

    func downloadImage(from url: String, completion: @escaping (Data?) -> Void) {
        repository?.request(url: url, completion: { result in
            switch result {
            case .success(let data):
                completion(data)
            default:
                break
            }
        })
    }
}
