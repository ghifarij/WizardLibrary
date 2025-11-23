//
//  RetryableNetworkService.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation
import Combine

extension NetworkService {
    func requestWithRetry<T: Codable>(
        _ endpoint: Endpoint,
        responseType: T.Type,
        maxRetries: Int = 3
    ) -> AnyPublisher<T, NetworkError> {
        request(endpoint, responseType: responseType)
            .retry(maxRetries)
            .catch { error -> AnyPublisher<T, NetworkError>
                in if case NetworkError.serverError = error {
                    return Just(T.self)
                        .delay(for: .seconds(1), scheduler: DispatchQueue.global())
                        .flatMap { _ in
                            self.request(endpoint, responseType: responseType)
                        }
                        .eraseToAnyPublisher()
                }
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
