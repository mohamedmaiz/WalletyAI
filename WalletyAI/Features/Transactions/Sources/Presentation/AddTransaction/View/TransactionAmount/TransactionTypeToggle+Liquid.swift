//
//  TransactionTypeTogle+Liquid.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//

import SwiftUI

struct LiquidToggle: View {
    @Binding var transactionType: TransactionType
    @Namespace private var animation
    
    var body: some View {
        HStack {
            toggleButton(title: "Expense", type: .expense)
            toggleButton(title: "Income", type: .income)
        }
        .frame(maxWidth: 260,maxHeight: 40)
        .padding(4)
        .glassEffect(.clear.interactive())
        .clipShape(Capsule())
    }
    
    @ViewBuilder
    func toggleButton(title: String, type: TransactionType) -> some View {
        Button {
            withAnimation(.spring()) {
                transactionType = type
            }
        } label: {
            Text(title)
                .font(.system(size: 14 , weight: .semibold))
                .foregroundColor(transactionType == type ? .white : .blueGray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        if transactionType == type {
                            Capsule()
                                .fill(
                                    type == .expense ? Color.darkBlueViolet : .successGreen
                                )
                                .matchedGeometryEffect(id: "tab", in: animation)
                        }
                    }
                )
        }
    }
}
