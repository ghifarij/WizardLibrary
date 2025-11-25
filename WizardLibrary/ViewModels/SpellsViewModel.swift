//
//  SpellsViewModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import Foundation
import Combine

class SpellsViewModel: ObservableObject {
    @Published var spells: [Spell] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var hasNextPage: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchSpells() {
        isLoading = true
        errorMessage = nil
        currentPage = 1
        
        let endpoint = SpellsEndpoint.getSpells(page: 1).endpoint
        
        networkService.request(endpoint, responseType: PotterSpellResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                self?.spells = response.data.map { $0.toDomain() }
                self?.hasNextPage = response.meta?.pagination?.hasNextPage ?? false
                self?.currentPage = response.meta?.pagination?.current ?? 1
            }
            .store(in: &cancellables)
    }
    
    func loadMoreSpells() {
        guard !isLoading && hasNextPage else { return }
        
        isLoading = true
        errorMessage = nil
        let nextPage = currentPage + 1
        
        let endpoint = SpellsEndpoint.getSpells(page: nextPage).endpoint
        
        networkService.request(endpoint, responseType: PotterSpellResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] response in
                self?.spells.append(contentsOf: response.data.map { $0.toDomain() })
                self?.hasNextPage = response.meta?.pagination?.hasNextPage ?? false
                self?.currentPage = response.meta?.pagination?.current ?? 1
            }
            .store(in: &cancellables)
    }
}
