//
//  TransactionRepository.swift
//  SpendInsight
//
//  Created by mac on 19/2/2026.
//
import Foundation

public protocol TransactionRepository {
    // Fetch transactions with pagination. Defaults: limit = 100, offset = 0
    func fetchTransactions(limit: Int, offset: Int) throws -> [Transaction]?

    func addNewTransaction(transaction: Transaction) throws -> Transaction
    func deleteTransaction(id: UUID) throws
    func updateTransaction(transaction: Transaction) throws
    func observeTransactionChange() -> AsyncStream<TransactionChange>
}
