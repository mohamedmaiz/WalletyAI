//
//  AddNewTransactionUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//
import Foundation

protocol InsertTransactionUseCaseProtocol {
    func execute(title: String , description: String? , amount: Double , type: TransactionType , parent: UUID? , date: Date) throws -> Transaction
}
