//
//  MoviesViewModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchMovies() {
        isLoading = true
        errorMessage = nil
        
        let endpoint = MoviesEndpoint.getMovies.endpoint
        
        networkService.request(endpoint, responseType: PotterMovieResponse.self)
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response  in
                self?.movies = response.data.map {
                    $0.toDomain()
                }
            }
            .store(in: &cancellables)
    }
}
