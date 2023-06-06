//
//  DefaultHomeInteractor.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import Service

public final class DefaultHomeInteractor: HomeInteractor {

    private let repository: NetworkRepository?
    private let endpoint = "api.tvmaze.com"

    public init(repository: NetworkRepository = DefaultNetworkRepository()) {
        self.repository = repository
    }

    public func fetchShows() {
        let path = "/shows"

        repository?.request(endpoint: endpoint, path: path, resultObject: [Show].self, completion: { result in
            switch result {
            case .success(let shows):
                break
            default:
                break
            }
        })
    }
}
