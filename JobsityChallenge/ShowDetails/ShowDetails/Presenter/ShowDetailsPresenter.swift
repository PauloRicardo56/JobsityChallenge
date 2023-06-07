//
//  ShowDetailsPresenter.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

protocol ShowDetailsPresenter {
    func showDetailsPresenter(showDetails show: ShowDetails.Response?)
    func showDetailsPresenter(showSeasons: [Int])
    func showDetailsPresenter(showEpisodes episodes: [ShowEpisodesModel.Response]?, from season: Int)
}
