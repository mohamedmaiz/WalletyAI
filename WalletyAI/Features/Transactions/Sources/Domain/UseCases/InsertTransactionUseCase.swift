//
//  AddNewTransactionUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//
import Foundation

class InsertTransactionUseCase: InsertTransactionUseCaseProtocol {
    let repo: TransactionRepository
    init(repo: TransactionRepository) {
        self.repo = repo
    }
    
    func execute(title: String , description: String? , amount: Double , type: TransactionType , parent: UUID? , date: Date) throws -> Transaction {
        return try repo
            .addNewTransaction(
                transaction: Transaction(
                    id: UUID(),
                    amount: amount,
                    type: type,
                    title: title,
                    description: description,
                    date: date,
                    categoryID: parent,
                    categoryName: nil,
                    categoryIcon: nil,
                )
            )
    }
}

