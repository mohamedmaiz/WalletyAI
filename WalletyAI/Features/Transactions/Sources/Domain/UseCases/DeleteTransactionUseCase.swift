//
//  DeleteTransactionUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

import Foundation
struct DeleteTransactionUseCase: DeleteTransactionUseCaseProtocol {
    private let repo: TransactionRepository
    
    init(repo: TransactionRepository) {
        self.repo = repo
    }
    
    func execute(id: UUID) throws {
        try repo.deleteTransaction(id: id)
    }
}

