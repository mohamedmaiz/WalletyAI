//
//  ObserveTransactionsUseCase.swift
//  SpendInsight
//
//  Created by mac on 26/2/2026.
//

import Foundation

protocol ObserveTransactionsUseCaseProtocol {
    func observeTransactionChange() -> AsyncStream<TransactionChange>
}
