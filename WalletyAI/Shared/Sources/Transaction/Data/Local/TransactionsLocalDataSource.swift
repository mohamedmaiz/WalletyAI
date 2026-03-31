//
//  TransactionsLocalDataSource.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//
import Foundation

protocol TransactionsLocalDataSource {
    // Fetch transactions with pagination. Defaults: limit = 100, offset = 0
    func fetchTransactions(limit: Int, offset: Int) throws -> [TransactionEntity]

    // Create
    func addNewTransaction(transaction: Transaction) throws -> TransactionEntity

    // Update
    func updateTransaction(transaction: Transaction) throws -> TransactionEntity

    // Delete
    func deleteTransaction(transactionID: UUID) throws
}
