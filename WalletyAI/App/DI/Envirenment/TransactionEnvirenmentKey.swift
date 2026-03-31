//
//  TransactionEnvirenmentKey.swift
//  SpendInsight
//
//  Created by mac on 10/3/2026.
//

import SwiftUI

private struct TransactionContainerKey: EnvironmentKey {
    static let defaultValue: TransactionDIContainer = {
        fatalError(
            """
            TransactionDIContainer not injected.
            Did you forget .environmentObject(transactionContainer)
            in AppCoordinator?
            """
        )
    }()
}

extension EnvironmentValues {
    
    var transactionContainer: TransactionDIContainer {
        get { self[TransactionContainerKey.self] }
        set { self[TransactionContainerKey.self] = newValue }
    }
}
