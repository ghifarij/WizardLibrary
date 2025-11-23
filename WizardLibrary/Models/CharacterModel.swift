//
//  CharacterModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation

// MARK: - Character attributes from PotterDB

struct PotterCharacterAttributes: Codable {
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

// MARK: - Domain model

struct Character: Identifiable, Equatable {
    let id: String
    let name: String
    let house: String?
    let imageURL: String?
    let bloodStatus: String?
    let gender: String?
    let born: String?
    let died: String?
    let nationality: String?
    let patronus: String?
    let eyeColor: String?
    let hairColor: String?
    let skinColor: String?
    let height: String?
    let weight: String?
    let animagus: String?
    let boggart: String?
    let aliasNames: [String]?
    let familyMembers: [String]?
    let jobs: [String]?
    let romances: [String]?
    let species: String?
    let titles: [String]?
    let wand: [String]?
}

extension PotterResource where Attributes == PotterCharacterAttributes {
    func toDomain() -> Character {
        Character(
            id: id,
            name: attributes.name,
            house: attributes.house,
            imageURL: attributes.imageURL,
            bloodStatus: attributes.bloodStatus,
            gender: attributes.gender,
            born: attributes.born,
            died: attributes.died,
            nationality: attributes.nationality,
            patronus: attributes.patronus,
            eyeColor: attributes.eyeColor,
            hairColor: attributes.hairColor,
            skinColor: attributes.skinColor,
            height: attributes.height,
            weight: attributes.weight,
            animagus: attributes.animagus,
            boggart: attributes.boggart,
            aliasNames: attributes.aliasNames,
            familyMembers: attributes.familyMembers,
            jobs: attributes.jobs,
            romances: attributes.romances,
            species: attributes.species,
            titles: attributes.titles,
            wand: attributes.wand
        )
    }
}
