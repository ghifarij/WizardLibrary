//
//  CharacterModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation

// MARK: - API Response with Pagination (JSON:API format)

struct PotterCharacterResponse: Codable, Equatable {
    let data: [CharacterResource]
    let meta: PotterPagination?
}

struct SingleCharacterResponse: Codable, Equatable {
    let data: CharacterResource?
}

struct CharacterResource: Codable, Equatable {
    let id: String
    let type: String
    let attributes: CharacterAttributes
}

struct CharacterAttributes: Codable, Equatable {
    let aliasNames: [String]?
    let animagus: String?
    let bloodStatus: String?
    let boggart: String?
    let born: String?
    let died: String?
    let eyeColor: String?
    let familyMembers: [String]?
    let gender: String?
    let hairColor: String?
    let height: String?
    let house: String?
    let imageURL: String?
    let jobs: [String]?
    let name: String
    let nationality: String?
    let patronus: String?
    let romances: [String]?
    let skinColor: String?
    let species: String?
    let titles: [String]?
    let wand: [String]?
    let weight: String?
    let slug: String

    enum CodingKeys: String, CodingKey {
        case aliasNames = "alias_names"
        case animagus
        case bloodStatus = "blood_status"
        case boggart
        case born
        case died
        case eyeColor = "eye_color"
        case familyMembers = "family_members"
        case gender
        case hairColor = "hair_color"
        case height
        case house
        case imageURL = "image"
        case jobs
        case name
        case nationality
        case patronus
        case romances
        case skinColor = "skin_color"
        case species
        case titles
        case wand
        case weight
        case slug
    }
}

// MARK: - Domain Model

struct Character: Identifiable, Equatable {
    let id: String
    let aliasNames: [String]?
    let animagus: String?
    let bloodStatus: String?
    let boggart: String?
    let born: String?
    let died: String?
    let eyeColor: String?
    let familyMembers: [String]?
    let gender: String?
    let hairColor: String?
    let height: String?
    let house: String?
    let imageURL: String?
    let jobs: [String]?
    let name: String
    let nationality: String?
    let patronus: String?
    let romances: [String]?
    let skinColor: String?
    let species: String?
    let titles: [String]?
    let wand: [String]?
    let weight: String?
    let slug: String
}

extension CharacterResource {
    func toDomain() -> Character {
        Character(
            id: id,
            aliasNames: attributes.aliasNames,
            animagus: attributes.animagus,
            bloodStatus: attributes.bloodStatus,
            boggart: attributes.boggart,
            born: attributes.born,
            died: attributes.died,
            eyeColor: attributes.eyeColor,
            familyMembers: attributes.familyMembers,
            gender: attributes.gender,
            hairColor: attributes.hairColor,
            height: attributes.height,
            house: attributes.house,
            imageURL: attributes.imageURL,
            jobs: attributes.jobs,
            name: attributes.name,
            nationality: attributes.nationality,
            patronus: attributes.patronus,
            romances: attributes.romances,
            skinColor: attributes.skinColor,
            species: attributes.species,
            titles: attributes.titles,
            wand: attributes.wand,
            weight: attributes.weight,
            slug: attributes.slug
        )
    }
}

enum CharacterSortOption: String, CaseIterable, Codable {
    case nameAscending
    case nameDescending

    var id: String { rawValue }

    var title: String {
        switch self {
        case .nameAscending:  return "Name (A–Z)"
        case .nameDescending: return "Name (Z–A)"
        }
    }
}
