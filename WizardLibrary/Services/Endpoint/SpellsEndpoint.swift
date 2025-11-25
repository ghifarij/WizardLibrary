//
//  SpellsEndpoint.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

enum SpellsEndpoint {
    case getSpells(page: Int)
    case getSpell(id: Int)
    
    var endpoint: Endpoint {
        switch self {
        case.getSpells(let page):
            return Endpoint(
                path: "/spells",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: ["page[number]": String(page)]
            )
            
        case .getSpell(let id):
            return Endpoint(
                path: "/spells/\(id)",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
            
        }
    }
}
