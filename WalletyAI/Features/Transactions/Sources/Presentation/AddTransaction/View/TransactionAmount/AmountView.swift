//
//  AmountView.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//
import SwiftUI

struct AmountView: View {
    @Binding var text: String
    @Binding var transactionType: TransactionType
    
    var body: some View {
        VStack{
            Text("AMOUNT")
                .font(.system(size: 14 , weight: .medium))
                .foregroundStyle(.blueGray)
            
            HStack(alignment: .bottom){
                Text("$")
                    .font(.system(size: 28 , weight: .medium))
                    .foregroundStyle(
                        transactionType == .expense ? .darkBlueViolet : .successGreen
                    )
                
                Text("\(text.isEmpty ? "0.0" : text)")
                    .font(.system(size: 48 , weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .frame(
            maxWidth: .infinity , maxHeight: 140
        )
        .background(.white.opacity(0.05))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 40)
                .stroke(.white.opacity(0.5))
        })
        .cornerRadius(40)
        .padding(.horizontal , 30)
    }
}
