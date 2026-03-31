//
//  FetchTransactionsUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

class FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {
    let repo: TransactionRepository
    init(repo: TransactionRepository) {
        self.repo = repo
    }
    
    // Paginated fetch with defaults (limit 100, offset 0)
    func execute(limit: Int = 100, offset: Int = 0) throws -> [Transaction]? {
        return try repo.fetchTransactions(limit: limit, offset: offset)
    }
}
