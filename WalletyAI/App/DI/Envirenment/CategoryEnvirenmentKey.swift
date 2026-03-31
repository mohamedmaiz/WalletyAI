//
//  CategoryEnvirenmentKey.swift
//  SpendInsight
//
//  Created by mac on 10/3/2026.
//
import SwiftUI

private struct CategoryContainerKey: EnvironmentKey {
    static let defaultValue: CategoriesDIContainer = {
           fatalError(
               """
               CategoriesDIContainer not injected.
               Did you forget .environmentObject(transactionContainer)
               in AppCoordinator?
               """
           )
       }()
}

extension EnvironmentValues {
    
    var categoryContainer: CategoriesDIContainer {
        get { self[CategoryContainerKey.self] }
        set { self[CategoryContainerKey.self] = newValue }
    }
}
