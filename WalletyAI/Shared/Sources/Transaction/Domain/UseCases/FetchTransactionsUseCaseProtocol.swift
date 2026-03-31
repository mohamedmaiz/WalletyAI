//
//  FetchTransactionsUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

protocol FetchTransactionsUseCaseProtocol {
    func execute(limit: Int, offset: Int) throws -> [Transaction]?
}
