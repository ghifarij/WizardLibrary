//
//  PaginationModel.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

struct PotterPagination: Codable, Equatable {
    let pagination: PaginationDetails?
}

struct PaginationDetails: Codable, Equatable {
    let current: Int?
    let last: Int?
    let records: Int?
    
    var hasNextPage: Bool {
        guard let current, let last else { return false }
        return current < last
    }
}
