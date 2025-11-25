//
//  MovieModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import Foundation

// MARK: - API Response (JSON:API format)

struct PotterMovieResponse: Codable {
    let data: [MovieResource]
}

struct MovieResource: Codable, Equatable {
    let id: String
    let type: String
    let attributes: MovieAttributes
}

struct SingleMovieResponse: Codable, Equatable {
    let data: MovieResource?
}

struct MovieAttributes: Codable, Equatable {
    let boxOffice: String?
    let budget: String?
    let cinematographers: [String]?
    let directors: [String]?
    let distributors: [String]?
    let editors: [String]?
    let musicComposers: [String]?
    let poster: String?
    let producers: [String]?
    let rating: String?
    let releaseDate: String?
    let runningTime: String?
    let screenwriters: [String]?
    let slug: String
    let summary: String?
    let title: String
    let trailer: String?
    let wiki: String?

    enum CodingKeys: String, CodingKey {
        case boxOffice = "box_office"
        case budget
        case cinematographers
        case directors
        case distributors
        case editors
        case musicComposers = "music_composers"
        case poster
        case producers
        case rating
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case screenwriters
        case slug
        case summary
        case title
        case trailer
        case wiki
    }
}

// MARK: - Domain Model

struct Movie: Identifiable, Equatable {
    let id: String
    let boxOffice: String?
    let budget: String?
    let cinematographers: [String]?
    let directors: [String]?
    let distributors: [String]?
    let editors: [String]?
    let musicComposers: [String]?
    let posterURL: URL?
    let producers: [String]?
    let rating: String?
    let releaseDate: String?
    let runningTime: String?
    let screenwriters: [String]?
    let slug: String
    let summary: String?
    let title: String
    let trailerURL: URL?
    let wikiURL: URL?
}

extension MovieResource {
    func toDomain() -> Movie {
        Movie(
            id: id,
            boxOffice: attributes.boxOffice,
            budget: attributes.budget,
            cinematographers: attributes.cinematographers,
            directors: attributes.directors,
            distributors: attributes.distributors,
            editors: attributes.editors,
            musicComposers: attributes.musicComposers,
            posterURL: attributes.poster.flatMap(URL.init(string:)),
            producers: attributes.producers,
            rating: attributes.rating,
            releaseDate: attributes.releaseDate,
            runningTime: attributes.runningTime,
            screenwriters: attributes.screenwriters,
            slug: attributes.slug,
            summary: attributes.summary,
            title: attributes.title,
            trailerURL: attributes.trailer.flatMap(URL.init(string:)),
            wikiURL: attributes.wiki.flatMap(URL.init(string:))
        )
    }
}
