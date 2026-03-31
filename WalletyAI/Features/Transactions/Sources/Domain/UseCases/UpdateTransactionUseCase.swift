//
//  UpdateTransactionUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

import Foundation

struct UpdateTransactionUseCase: UpdateTransactionUseCaseProtocol {
    private let repo: TransactionRepository
    
    init(repo: TransactionRepository) {
        self.repo = repo
    }
    
    func execute(_ transaction: Transaction) throws {
        try repo.updateTransaction(transaction: transaction)
    }
}

