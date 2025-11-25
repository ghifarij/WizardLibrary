//
//  PotionModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import Foundation

// MARK: - API Response with Pagination (JSON:API format)

struct PotterPotionResponse: Codable, Equatable {
    let data: [PotionResource]
    let meta: PotterPagination?
}

struct PotionResource: Codable, Equatable {
    let id: String
    let type: String
    let attributes: PotionAttributes
}

struct PotionAttributes: Codable, Equatable {
    let characteristics: String?
    let difficulty: String?
    let effect: String?
    let imageURL: String?
    let inventors: String?
    let ingredients: String?
    let manufacturers: String?  
    let name: String
    let sideEffects: String?
    let slug: String
    let time: String?
    let wiki: String?
    
    enum CodingKeys: String, CodingKey {
        case characteristics
        case difficulty
        case effect
        case imageURL = "image"
        case inventors
        case ingredients
        case manufacturers
        case name
        case sideEffects = "side_effects"
        case slug
        case time
        case wiki
    }
}

// MARK: - Domain Model

struct Potion: Identifiable, Equatable {
    let id: String
    let characteristics: String?
    let difficulty: String?
    let effect: String?
    let imageURL: String?
    let inventors: String?
    let ingredients: String?
    let manufacturers: String?
    let name: String
    let sideEffects: String?
    let slug: String
    let time: String?
    let wiki: String?
}

extension PotionResource {
    func toDomain() -> Potion {
        Potion(
            id: id,
            characteristics: attributes.characteristics,
            difficulty: attributes.difficulty,
            effect: attributes.effect,
            imageURL: attributes.imageURL,
            inventors: attributes.inventors,
            ingredients: attributes.ingredients,
            manufacturers: attributes.manufacturers,
            name: attributes.name,
            sideEffects: attributes.sideEffects,
            slug: attributes.slug,
            time: attributes.time,
            wiki: attributes.wiki
        )
    }
}
