//
//  CategoryItemView.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//
import SwiftUI

public struct CategoryItemView: View {
    let category: Category
    let isSelected: Bool
    let selectedColor: Color
    
    var body: some View {
        HStack() {
            Image(category.icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 18 , height: 18)
                .scaledToFit()
                .foregroundStyle(
                    isSelected ?  Color(hex: category.color) : .white
                )
           
            Text(category.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(isSelected ? Color(hex: category.color) : .blueGray)
        }
        .frame(height: 40)
        .padding(.horizontal , 12)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(
                    isSelected ? Color(hex: category.color)
                        .opacity(0.2) : .blueGray
                        .opacity(0.1)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            isSelected ? Color(hex: category.color) : .white
                                .opacity(0.1) ,
                            lineWidth: 0.5
                        )
                }
                
        }
        
    }
}
