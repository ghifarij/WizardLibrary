//
//  NetworkError.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case serverError
    case networkUnavailable
}

extension NetworkError {
    var userMessage: String {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .networkUnavailable:
            return "Unable to connect. Please check your internet connection."
        case .decodingFailed:
            return "Failed to load the data. Please try again later."
        case .serverError:
            return "Server returned an error."
        case .noData:
            return "No data received. Please try again."
        }
    }
}
