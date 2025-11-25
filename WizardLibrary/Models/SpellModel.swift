//
//  SpellModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import Foundation

// MARK: - API Response with Pagination (JSON:API format)

struct PotterSpellResponse: Codable, Equatable {
    let data: [SpellResource]
    let meta: PotterPagination?
}

struct SpellResource: Codable, Equatable {
    let id: String
    let type: String
    let attributes: SpellAttributes
}

struct SingleSpellResponse: Codable, Equatable {
    let data: SpellResource?
}

struct SpellAttributes: Codable, Equatable {
    let category: String?
    let creator: String?
    let effect: String?
    let hand: String?
    let imageURL: String?
    let incantation: String?
    let light: String?
    let name: String
    let slug: String
    let wiki: String?
    
    enum CodingKeys: String, CodingKey {
        case category
        case creator
        case effect
        case hand
        case imageURL = "image"
        case incantation
        case light
        case name
        case slug
        case wiki
    }
}

// MARK: - Domain Model

struct Spell: Identifiable, Equatable {
    let id: String
    let category: String?
    let creator: String?
    let effect: String?
    let hand: String?
    let imageURL: String?
    let incantation: String?
    let light: String?
    let name: String
    let slug: String
    let wiki: String?
}

extension SpellResource {
    func toDomain() -> Spell {
        Spell(
            id: id,
            category: attributes.category,
            creator: attributes.creator,
            effect: attributes.effect,
            hand: attributes.hand,
            imageURL: attributes.imageURL,
            incantation: attributes.incantation,
            light: attributes.light,
            name: attributes.name,
            slug: attributes.slug,
            wiki: attributes.wiki
        )
    }
}
