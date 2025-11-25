//
//  MoviesEndpoint.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

enum MoviesEndpoint {
    case getMovies
    case getMovie(id: Int)
    
    var endpoint: Endpoint {
        switch self {
        case.getMovies:
            return Endpoint(
                path: "/movies",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
            
        case .getMovie(let id):
            return Endpoint(
                path: "/movies/\(id)",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
            
        }
    }
}
