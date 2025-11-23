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
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCharacters() {
        isLoading = true
        errorMessage = nil
        
        let endpoint = CharactersEndpoint.getCharacters.endpoint
        
        networkService.request(endpoint, responseType: PotterListResponse<PotterCharacterAttributes>.self)
            .map { response in
                response.data.map { $0.toDomain() }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] characters in
                self?.characters = characters
            }
            .store(in: &cancellables)
    }
}
