//
//  ShowEpisodesModel.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit

struct ShowEpisodesModel {
    struct Response: Codable {
        let id: Int
        let url: String
        let name: String
        let season, number: Int?
        let type, airdate, airtime: String?
        let airstamp: String?
        let runtime: Int?
        let rating: Rating?
        let image: Image?
        let summary: String?
        let links: Links?

        enum CodingKeys: String, CodingKey {
            case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
            case links = "_links"
        }

        struct Image: Codable {
            let medium, original: String?
        }

        struct Links: Codable {
            let linksSelf, show: SelfClass?

            enum CodingKeys: String, CodingKey {
                case linksSelf = "self"
                case show
            }
        }

        struct SelfClass: Codable {
            let href: String?
        }

        struct Rating: Codable {
            let average: Double?
        }
    }

    struct ViewObject {
        let image: UIImageView
        let name: String
        let episodeAndSeasonNumber: String
        let summary: String
    }
}
