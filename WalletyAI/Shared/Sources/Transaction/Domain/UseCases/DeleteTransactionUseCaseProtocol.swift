//
//  DeleteTransactionUseCase.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

import Foundation
protocol DeleteTransactionUseCaseProtocol {
    func execute(id: UUID) throws
}
