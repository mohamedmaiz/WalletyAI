//
//  MockTransactionRepository.swift
//  SpendInsight
//
//  Created by mac on 23/2/2026.
//

import Foundation

class MockTransactionRepository: TransactionRepository {

    func observeTransactionChange() -> AsyncStream<TransactionChange> {
        AsyncStream { continuation in
            // Emit a few mock changes, then finish. This is suitable for previews/tests.
            Task {
                // Added transaction
                let added = Transaction(
                    id: UUID(),
                    amount: 15.5,
                    type: .expense,
                    title: "Coffee",
                    description: "Latte",
                    date: Date()
                )
               

                // Updated transaction
                let updated = Transaction(
                    id: added.id,
                    amount: 16.0,
                    type: .expense,
                    title: "Coffee",
                    description: "Latte with extra shot",
                    date: added.date
                )
                continuation.yield(.updated(updated))

                // Deleted transaction
                continuation.yield(.deleted(UUID()))

                // Finish the stream
                continuation.finish()
            }
        }
    }

    func fetchTransactions(limit: Int = 0, offset: Int = 100) throws -> [Transaction]? {
        [
            .init(
                id: UUID(),
                amount: 200.0,
                type: .expense,
                title: "Gift",
                description: "Gift for my mom",
                date: Date()
            ),
            .init(
                id: UUID(),
                amount: 120.0,
                type: .expense,
                title: "Food",
                description: nil ,
                date: Date()
            ),
            .init(
                id: UUID(),
                amount: 1000,
                type: .income,
                title: "Salary",
                description: nil,
                date: Date()
            )

        ]
    }

    func addNewTransaction(transaction: Transaction) throws -> Transaction {
        return transaction
    }

    func deleteTransaction(id: UUID) throws {
        
    }

    func updateTransaction(transaction: Transaction) throws {
        
    }

    
}
