//
//  EpisodeDetailsModel.swift
//  EpisodeDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit

public struct EpisodeDetailsModel {
    public struct ViewObject {
        let image: UIImageView
        let name: String
        let episodeAndSeasonNumber: String
        let summary: String

        public init(image: UIImageView, name: String, episodeAndSeasonNumber: String, summary: String) {
            self.image = image
            self.name = name
            self.episodeAndSeasonNumber = episodeAndSeasonNumber
            self.summary = summary
        }
    }
}
