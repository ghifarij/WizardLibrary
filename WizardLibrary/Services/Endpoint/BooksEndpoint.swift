//
//  BooksEndpoint.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

enum BooksEndpoint {
    case getBooks
    case getBook(id: Int)
    case getChapters(bookId: Int)
    
    var endpoint: Endpoint {
        switch self {
        case.getBooks:
            return Endpoint(
                path: "/books",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
            
        case .getBook(let id):
            return Endpoint(
                path: "/books/\(id)",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
        
        case .getChapters(let bookId):
            return Endpoint(
                path: "/books/\(bookId)/chapters",
                method: .GET,
                headers: ["Content-Type": "application/json"],
                parameters: nil
            )
        }
    }
}
