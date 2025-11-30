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
    @Published var selectedCharacter: Character?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var hasNextPage: Bool = false
    @Published var sortOption: CharacterSortOption = .nameAscending
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        // React to sort option changes by resetting pagination
        $sortOption
            .dropFirst()
            .sink { [weak self] _ in
                self?.resetForSortChange()
            }
            .store(in: &cancellables)
    }
    
    var sortedCharacters: [Character] {
        switch sortOption {
        case .nameAscending:
            return characters.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .nameDescending:
            return characters.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedDescending }
        }
    }

    
    func fetchCharacters() {
        isLoading = true
        errorMessage = nil
        currentPage = 1
        
        let endpoint = CharactersEndpoint.getCharacters(page: 1).endpoint

        networkService.request(endpoint, responseType: PotterCharacterResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.isLoading = false
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                let firstPageCharacters = response.data.map { $0.toDomain() }
                self.totalPages = response.meta?.pagination?.last ?? 1
                let current = response.meta?.pagination?.current ?? 1

                switch self.sortOption {
                case .nameAscending:
                    self.characters = firstPageCharacters
                    self.currentPage = current
                    self.hasNextPage = current < self.totalPages
                    self.isLoading = false
                case .nameDescending:
                    // If more than one page, load the last page first
                    let lastPage = self.totalPages
                    if lastPage > 1 {
                        let lastEndpoint = CharactersEndpoint.getCharacters(page: lastPage).endpoint
                        self.networkService.request(lastEndpoint, responseType: PotterCharacterResponse.self)
                            .receive(on: DispatchQueue.main)
                            .sink { [weak self] completion in
                                self?.isLoading = false
                                if case .failure(let error) = completion {
                                    self?.errorMessage = error.userMessage
                                }
                            } receiveValue: { [weak self] lastResponse in
                                guard let self else { return }
                                self.characters = lastResponse.data.map { $0.toDomain() }
                                self.currentPage = lastPage
                                self.hasNextPage = self.currentPage > 1
                            }
                            .store(in: &self.cancellables)
                    } else {
                        // Only one page available
                        self.characters = firstPageCharacters
                        self.currentPage = current
                        self.hasNextPage = false
                        self.isLoading = false
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func loadMoreCharacters() {
        // Determine if there are more pages based on sort direction
        let canLoadMore: Bool = {
            switch sortOption {
            case .nameAscending:
                return currentPage < totalPages
            case .nameDescending:
                return currentPage > 1
            }
        }()
        guard !isLoading && canLoadMore else { return }

        isLoading = true
        errorMessage = nil

        let nextPage: Int = {
            switch sortOption {
            case .nameAscending: return currentPage + 1
            case .nameDescending: return currentPage - 1
            }
        }()

        let endpoint = CharactersEndpoint.getCharacters(page: nextPage).endpoint

        networkService.request(endpoint, responseType: PotterCharacterResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                let newCharacters = response.data.map { $0.toDomain() }
                // Append; view will re-sort using sortedCharacters
                self.characters.append(contentsOf: newCharacters)
                self.currentPage = response.meta?.pagination?.current ?? nextPage

                switch self.sortOption {
                case .nameAscending:
                    self.hasNextPage = self.currentPage < self.totalPages
                case .nameDescending:
                    self.hasNextPage = self.currentPage > 1
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchCharacter(id: String) {
        isLoading = true
        errorMessage = nil
        
        let endpoint = CharactersEndpoint.getCharacter(id: id).endpoint
        
        networkService.request(endpoint, responseType: SingleCharacterResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                self?.selectedCharacter = response.data?.toDomain()
            }
            .store(in: &cancellables)
    }
    
    func resetToFirstPage() {
        characters.removeAll()
        currentPage = 1
        hasNextPage = true
        fetchCharacters()
    }

    private func resetForSortChange() {
        characters.removeAll()
        errorMessage = nil
        currentPage = 1
        hasNextPage = false
        fetchCharacters()
    }
}
