//
//  ShowSeasonsModel.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

struct ShowSeasons {
    struct Response: Codable {
        let id: Int
        let url: String
        let number: Int
        let name: String
        let episodeOrder: Int?
        let premiereDate, endDate: String?
        let network: Network?
        let image: Image?
        let summary: String?
        let links: Links?

        enum CodingKeys: String, CodingKey {
            case id, url, number, name, episodeOrder, premiereDate, endDate, network, image, summary
            case links = "_links"
        }
    }

    struct Image: Codable {
        let medium, original: String
    }

    struct Links: Codable {
        let linksSelf: SelfClass

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
        }
    }

    struct SelfClass: Codable {
        let href: String
    }

    struct Network: Codable {
        let id: Int
        let name: String
        let country: Country
        let officialSite: String
    }

    struct Country: Codable {
        let name, code, timezone: String
    }
}
