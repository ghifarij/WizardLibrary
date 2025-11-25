//
//  BooksViewModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import Foundation
import Combine

class BooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var selectedBook: Book?
    @Published var chapters: [Chapter] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        fetchBooks()
    }
    
    func fetchBooks() {
        isLoading = true
        errorMessage = nil
        
        let endpoint = BooksEndpoint.getBooks.endpoint
        
        networkService.request(endpoint, responseType: PotterBookResponse.self)
            .map { response in
                response.data.map { $0.toDomain() }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] books in
                self?.books = books
            }
            .store(in: &cancellables)
    }
    
    func fetchBook(id: String) {
        isLoading = true
        errorMessage = nil
        chapters = []
        
        let bookEndpoint = BooksEndpoint.getBook(id: id).endpoint
        let chaptersEndpoint = BooksEndpoint.getChapters(bookId: id).endpoint
        
        let bookPublisher = networkService.request(bookEndpoint, responseType: SingleBookResponse.self)
        let chaptersPublisher = networkService.request(chaptersEndpoint, responseType: PotterChapterResponse.self)
        
        Publishers.Zip(bookPublisher, chaptersPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.userMessage
                }
            } receiveValue: { [weak self] bookResponse, chaptersResponse in
                self?.selectedBook = bookResponse.data?.toDomain()
                self?.chapters = chaptersResponse.data.map { $0.toDomain() }
                    .sorted { ($0.order ?? Int.max) < ($1.order ?? Int.max) }
            }
            .store(in: &cancellables)
    }
    
    func clearSelectedBook() {
        selectedBook = nil
        chapters = []
        errorMessage = nil
    }
}
