//
//  PotionsEndpoint.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

enum PotionsEndpoint {
    case getPotions(page: Int)
    case getPotion(id: String)
    
    var endpoint: Endpoint {
        switch self {
        case.getPotions(let page):
            return Endpoint(
                path: "/potions",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: ["page[number]": String(page)]
            )
            
        case .getPotion(let id):
            return Endpoint(
                path: "/potions/\(id)",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
            
        }
    }
}
