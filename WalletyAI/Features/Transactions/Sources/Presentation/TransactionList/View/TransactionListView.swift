//
//  Transaction.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

import SwiftUI
import Charts

struct TransactionListView: View {
    @ObservedObject var vm: TransactionListViewModel
    let onEditTransaction: (Transaction) -> Void
    let onDeleteTransaction: (Transaction) -> Void
    
    var body: some View {
        switch vm.transactionState {
        case .idle:
            idleView
        case .loading:
            loadingView
        case .data(_):
            if vm.daySections.isEmpty { emptyView } else { dataView }
        case .error(let error):
            errorView(error)
        default:
            EmptyView()
        }
        
    }
    
    
    // MARK: - Case Views
    
    private var idleView: some View {
        ProgressView("Preparing...")
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
    }
    
    private var loadingView: some View {
        ProgressView("Loading transactions…")
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
    }
    
    private var emptyView: some View {
        ContentUnavailableView("No transactions", systemImage: "tray")
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
    }
    private var dataView: some View {
        ForEach(vm.daySections) { section in
            Section(header: sectionHeader(for: section.date)) {
                ForEach(section.transactions) { transaction in
                    TransactionRow(transaction: transaction ,
                                   onDelete: onDeleteTransaction,
                                   onUpdate: onEditTransaction)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.bottom , 4)
                    
                }
            }
            .listRowInsets(EdgeInsets())
            .listSectionSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .background(.clear)
        
    }
    
    private func errorView(_ error: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
                .font(.title2)
                .foregroundStyle(.orange)
            Text(error)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button("Retry") { vm.fetchTransactions() }
                .buttonStyle(.borderedProminent)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }
    
    // MARK: - Helper Views
    private func sectionHeader(for date: Date) -> some View {
        let formatted = date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
        return Text(formatted)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.blueGray)
            .padding(.horizontal, 20)
            .padding(.bottom , 4)
    }
}


#Preview {
    
    let appContainer = AppContainer.preview
    
    Screen(background: .primaryScreen) {
        List{
            TransactionListView(
                vm: appContainer.makeTransactionFeature().makePreviewTransactionVM(),
                onEditTransaction: {_ in},
                onDeleteTransaction: {_ in}
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        
    }
    
}
