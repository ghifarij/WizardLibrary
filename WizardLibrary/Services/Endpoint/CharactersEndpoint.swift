//
//  CharactersEndpoint.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

enum CharactersEndpoint {
    case getCharacters
    case getCharacter(id: Int)
    
    var endpoint: Endpoint {
        switch self {
        case.getCharacters:
            return Endpoint(
                path: "/characters",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
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
