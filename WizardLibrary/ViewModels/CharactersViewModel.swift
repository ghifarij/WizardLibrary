//
//  CharactersViewModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var hasNextPage: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCharacters() {
        isLoading = true
        errorMessage = nil
        currentPage = 1
        
        let endpoint = CharactersEndpoint.getCharacters(page: 1).endpoint
        
        networkService.request(endpoint, responseType: PotterCharacterResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                self?.characters = response.data.map { $0.toDomain() }
                self?.hasNextPage = response.meta.pagination.hasNextPage
                self?.currentPage = response.meta.pagination.current
            }
            .store(in: &cancellables)
    }
    
    func loadMoreCharacters() {
        guard !isLoading && hasNextPage else { return }
        
        isLoading = true
        errorMessage = nil
        let nextPage = currentPage + 1
        
        let endpoint = CharactersEndpoint.getCharacters(page: nextPage).endpoint
        
        networkService.request(endpoint, responseType: PotterCharacterResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                self?.characters.append(contentsOf: response.data.map { $0.toDomain() })
                self?.hasNextPage = response.meta.pagination.hasNextPage
                self?.currentPage = response.meta.pagination.current
            }
            .store(in: &cancellables)
    }
}
