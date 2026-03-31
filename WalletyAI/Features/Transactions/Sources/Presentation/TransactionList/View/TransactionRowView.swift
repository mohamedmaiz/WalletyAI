//
//  TransactionRowView.swift
//  SpendInsight
//
//  Created by mac on 14/3/2026.
//
import SwiftUI
import Foundation

struct TransactionRow: View {
    let transaction: Transaction
    let onDelete: (Transaction) -> Void
    let onUpdate: (Transaction) -> Void
    
    var body: some View {
        HStack (alignment: .center) {
            Image(transaction.categoryIcon ?? "transaction")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 18 , height: 18)
                .foregroundStyle(.white)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 40, height: 40)
                )
                .padding(.trailing , 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                if let description = transaction.description {
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.blueGray)
                }
                
            }
            Spacer(minLength: 8)
            Text("-$\(String(format: "%.2f", transaction.amount))")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
        }
        
        .padding(.horizontal , 20)
        .frame(height: 64)
        .background(
            RoundedRectangle(cornerRadius: 60, style: .continuous)
                .fill(Color(hex: "#1F1A2B"))
        )
        .swipeActions(allowsFullSwipe: false) {
            swipeActionsButtons(for: transaction)
        }
        
        
    }
    
    @ViewBuilder
    private func swipeActionsButtons(for tx: Transaction) -> some View {
        
        Button("Duplicate") {
            print("Duplicate \(tx.title)")
        }
        .tint(.blue)
        .frame(maxHeight: 30)
        
        Button("Edit") {
            onUpdate(transaction)
        }
        .tint(.green)
        .frame(width: 30, height: 30)
        
        Button(role: .destructive) {
            onDelete(transaction)
        } label: {
            Text("Delete")
        }
        .tint(.red)
        .frame(width: 30, height: 30)
    }
}


#Preview {
    Color.background
        .overlay {
            TransactionRow(
                transaction: Transaction(
                    id: UUID(),
                    amount: 1200,
                    type: .expense,
                    title: "Preview Transaction",
                    description: "Preview Description",
                    date: Date()
                ),
                onDelete: {_ in
                },
                onUpdate: {_ in})
            
        }
}

