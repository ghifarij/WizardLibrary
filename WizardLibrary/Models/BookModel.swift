//
//  BookModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation

// MARK: - Generic JSON:API list response

struct PotterBookResponse<Attributes: Codable>: Codable {
    let data: [PotterResource<Attributes>]
}

struct PotterResource<Attributes: Codable>: Codable {
    let id: String
    let type: String
    let attributes: Attributes
}

// MARK: - Book attributes from PotterDB

struct PotterBookAttributes: Codable {
    let author: String?
    let cover: String?
    let dedication: String?
    let pages: Int?
    let releaseDate: String?
    let summary: String?
    let slug: String
    let title: String
    let wiki: String?

    enum CodingKeys: String, CodingKey {
        case author
        case cover
        case dedication
        case pages
        case releaseDate = "release_date"
        case summary
        case slug
        case title
        case wiki
    }
}

// MARK: - Chapter attributes from PotterDB

struct PotterChapterAttributes: Codable {
    let order: Int?
    let slug: String
    let summary: String?
    let title: String
}

// MARK: - Domain models

struct Book: Identifiable, Equatable {
    let id: String
    let title: String
    let author: String?
    let summary: String?
    let pages: Int?
    let releaseDate: String?
    let coverURL: URL?
}

struct Chapter: Identifiable, Equatable {
    let id: String
    let order: Int?
    let title: String
    let summary: String?
}

extension PotterResource where Attributes == PotterBookAttributes {
    func toDomain() -> Book {
        Book(
            id: id,
            title: attributes.title,
            author: attributes.author,
            summary: attributes.summary,
            pages: attributes.pages,
            releaseDate: attributes.releaseDate,
            coverURL: attributes.cover.flatMap(URL.init(string:))
        )
    }
}

extension PotterResource where Attributes == PotterChapterAttributes {
    func toDomain() -> Chapter {
        Chapter(
            id: id,
            order: attributes.order,
            title: attributes.title,
            summary: attributes.summary
        )
    }
}
