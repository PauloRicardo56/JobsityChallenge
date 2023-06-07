//
//  ShowDetailsInteractor.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

protocol ShowDetailsInteractor {
    func fetchShowDetails(with id: Int?)
    func fetchShowSeasons(with id: Int?)
    func fetchShowEpisodes(season: Int)
}
