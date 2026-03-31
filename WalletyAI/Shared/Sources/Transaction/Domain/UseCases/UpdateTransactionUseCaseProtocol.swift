//
//  UpdateTransactionUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

import Foundation
protocol UpdateTransactionUseCaseProtocol {
    func execute(_ transaction: Transaction) throws
}
