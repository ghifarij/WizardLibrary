//
//  CharactersEndpoint.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//


enum CharactersEndpoint {
    case getCharacters(page: Int)
    case getCharacter(id: String)
    
    var endpoint: Endpoint {
        switch self {
        case.getCharacters(let page):
            return Endpoint(
                path: "/characters",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: ["page[number]": String(page)]
            )
            
        case .getCharacter(let id):
            return Endpoint(
                path: "/characters/\(id)",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
            
        }
    }
}
