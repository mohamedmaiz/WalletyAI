//
//  AddTransactionSheet.swift
//  SpendInsight
//
//  Created by mac on 24/2/2026.
//

import SwiftUI


struct AddTransactionSheet: View {
    @StateObject var vm: AddTransactionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            
            if vm.step == 0 {
                TransactionAmountSection(
                    transactionType: $vm.transactionType,
                    amount: $vm.amount,
                    goToDetails: vm.goToDetailsView,
                    categories: $vm.categoriesState,
                    selectedCategory: $vm.selectedCategory,
                    state: $vm.insertTransactionState
                )
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .leading),
                        removal: .move(edge: .leading)
                    )
                )
            }
            
            if vm.step == 1 {
                TransactionDetailsSection(
                    transactionType: $vm.transactionType,
                    backToAmount: vm.backToAmountView,
                    title: $vm.title,
                    notes: $vm.notes,
                    date: $vm.date,
                    recurring: $vm.recurring,
                    state: $vm.insertTransactionState,
                    insertTransaction: vm.insertTransaction
                )
                .transition(
                    .asymmetric(
                        insertion:
                                .move(edge:  .trailing),
                        removal: .move(edge:  .trailing)
                    )
                )
            }
        }
        .onChange(of: vm.insertTransactionState) {
            if case .data = vm.insertTransactionState {
                dismiss()
            }
            
        }
        .animation(.easeInOut, value: vm.step)
    }
}

#Preview {
    let appContainer = AppContainer.preview
    AddTransactionSheet(vm: appContainer.makeTransactionFeature().makePreviewAddTransactionVM())
}
