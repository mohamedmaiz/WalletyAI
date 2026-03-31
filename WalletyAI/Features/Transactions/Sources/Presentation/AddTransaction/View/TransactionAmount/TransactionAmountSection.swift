//
//  TransactionAmountSection.swift
//  SpendInsight
//
//  Created by mac on 23/2/2026.
//

import SwiftUI

struct TransactionAmountSection: View {
    @Binding var transactionType: TransactionType
    @Binding var amount: String
    let goToDetails: () -> Void
    @Binding var categories: ViewState<[Category]>
    @Binding var selectedCategory: UUID?
    @Binding var state : ViewState<Bool>
    
    var body: some View {
            Screen(
                background: transactionType == .expense ? .expenseScreen : .incomeScreen
            ) {
                VStack{
                    LiquidToggle(transactionType: $transactionType)
                    AmountView(text: $amount , transactionType: $transactionType)
                        .padding(.top, 12)
                    
                    if (transactionType == .expense){
                        CategoryPickerView(
                            categories: $categories,
                            selectedCategory: $selectedCategory,
                            leadingPadding: 30
                        )
                        .padding(.top , 8)
                    }
                    
                    KeyboardContainerView(text: $amount)
                    
                    if let errorMessage = state.errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 4)
                    }
                    
                    AppButton(
                        title: "Add Transaction",
                        color: transactionType == .expense ? .darkBlueViolet : .successGreen
                    ) {
                        goToDetails()
                    }
                }
            }
            
        
    }
}


#Preview {    
    TransactionAmountSection(
        transactionType: .constant(.expense),
        amount: .constant(""),
        goToDetails: {
},
        categories: .constant(
            .data(
                [
                    .init(
                        id: UUID(),
                        name: "Preview",
                        color: "#ff4564",
                        icon: "home",
                        totalSpending: 200,
                        transactionCount: 22
                    )
        ]
)
),
        selectedCategory: .constant(nil),
        state: .constant(.idle)
    )
     
}












