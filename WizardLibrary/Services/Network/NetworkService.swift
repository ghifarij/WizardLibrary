//
//  NetworkService.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Codable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let baseURL: URL
    
    init(
        session: URLSession = .shared,
        baseURL: URL = URL(string: "https://api.potterdb.com/v1")!
    ) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func request<T:Codable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        guard let url = endpoint.url(baseURL: baseURL) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error in
                print(error)
                return NetworkError.decodingFailed
            }
            .eraseToAnyPublisher()
    }
}
