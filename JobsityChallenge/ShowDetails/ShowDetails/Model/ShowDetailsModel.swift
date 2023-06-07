//
//  ShowDetailsModel.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit

struct ShowDetails {
    struct Response: Codable {
        let id: Int
        let url: String
        let name, type, language: String
        let genres: [String]?
        let status: String?
        let runtime, averageRuntime: Int?
        let premiered, ended: String?
        let officialSite: String?
        let schedule: Schedule?
        let rating: Rating?
        let weight: Int?
        let network: Network?
        let externals: Externals?
        let image: Image?
        let summary: String?
        let updated: Int?
        let links: Links?

        enum CodingKeys: String, CodingKey {
            case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, externals, image, summary, updated
            case links = "_links"
        }

        struct Externals: Codable {
            let tvrage, thetvdb: Int?
            let imdb: String?
        }

        struct Image: Codable {
            let medium, original: String?
        }

        struct Links: Codable {
            let linksSelf, previousepisode: Previousepisode?

            enum CodingKeys: String, CodingKey {
                case linksSelf = "self"
                case previousepisode
            }
        }

        struct Previousepisode: Codable {
            let href: String?
        }

        struct Network: Codable {
            let id: Int?
            let name: String?
            let country: Country?
        }

        struct Country: Codable {
            let name, code, timezone: String?
        }

        struct Rating: Codable {
            let average: Double?
        }

        struct Schedule: Codable {
            let time: String?
            let days: [String]?
        }

    }

    struct ViewObject {
        let name: String
        let daysAired: String
        let genres: String
        let summary: String
    }
}
