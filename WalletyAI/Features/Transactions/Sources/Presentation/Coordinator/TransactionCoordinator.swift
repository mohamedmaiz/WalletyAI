//
//  TransactionCoordinator.swift
//  SpendInsight
//
//  Created by mac on 14/3/2026.
//
import SwiftUI
struct TransactionCoordinator: View {
    let container: TransactionDIContainer
    @StateObject var transactionListVM: TransactionListViewModel
    @StateObject var addTransactionVM: AddTransactionViewModel
    @StateObject var deleteTransactionHandler: DeleteTransactionHandler
    
    @State private var showAddTransactionSheet: Bool = false
    @State private var showAIInsightsSheet: Bool = false
    @State private var showUpdateSheet: Transaction? = nil
    
    
    init(
        container: TransactionDIContainer,
    ) {
        self.container = container
        self._transactionListVM = StateObject(
            wrappedValue:  container.makeTransactionVM()
        )
        self._addTransactionVM = StateObject(
            wrappedValue: container.makeAddTransactionVM()
        )
        self._deleteTransactionHandler = StateObject(
            wrappedValue: container.makeDeleteTransactionHandler()
        )
    }
    

    var body: some View {
        NavigationStack {
            DashboardScreen(
                vm: container.makeTransactionVM(),
                showAddTransactionSheet: {showAddTransactionSheet = true},
                showInsightSheet: {showAIInsightsSheet = true},
                onEditTransaction: {
                    transaction in showUpdateSheet = transaction
                },
                onDeleteTransaction: {
                    transaction in
                    deleteTransactionHandler
                        .onDelete(transaction: transaction)
                }
            )
        }
        .sheet(
            isPresented: $showAddTransactionSheet) {
                AddTransactionSheet(
                    vm: container.makeAddTransactionVM()
                )
            }
        .sheet(isPresented: $showAIInsightsSheet) {
                AIInsightsView()
        }
        .sheet(item: $showUpdateSheet) { transaction in
            EditTransactionSheet(
                vm: container.makeEditTransactionVM(transaction: transaction)
            )
        }
    }
    
}
