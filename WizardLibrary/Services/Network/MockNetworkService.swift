//
//  MockNetworkService.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation
import Combine

class MockNetworkService: NetworkServiceProtocol {
    private var mockResponses: [String: Data] = [:]
    private var shouldFail: Bool = false
    
    func setMockResponse<T: Codable>(_ response: T, for endpoint: String) {
        if let data = try? JSONEncoder().encode(response) {
            mockResponses[endpoint] = data
        }
    }
    
    func setShouldFail(_ shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
    
    func request<T: Codable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        if shouldFail {
            return Fail(error: NetworkError.networkUnavailable)
                .eraseToAnyPublisher()
        }
        guard let data = mockResponses[endpoint.path] else {
            return Fail(error: NetworkError.noData)
                .eraseToAnyPublisher()
        }
        
        return Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingFailed }
            .eraseToAnyPublisher()
    }
}
