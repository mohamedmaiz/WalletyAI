//
//  ObserveTransactionsUseCase.swift
//  SpendInsight
//
//  Created by mac on 26/2/2026.
//

import Foundation

class ObserveTransactionsUseCase: ObserveTransactionsUseCaseProtocol {
    let repo: TransactionRepository
    
    init(repo: TransactionRepository) {
        self.repo = repo
    }
    
    func observeTransactionChange() -> AsyncStream<TransactionChange> {
        repo.observeTransactionChange()
    }
}
