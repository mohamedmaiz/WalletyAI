//
//  CategoryPicker.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//
import SwiftUI
import Foundation

public struct CategoryPickerView: View {
    @Binding var categories: ViewState<[Category]>
    @Binding var selectedCategory: UUID?
    let leadingPadding: Double
    
    public var body: some View {
        
        switch categories {
        case .data(let categories):
            VStack(alignment: .leading) {
                Text("SELECT CATEGORY")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.bottom , 6)
                    .padding(.leading, leadingPadding)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories) { category in
                            CategoryItemView(
                                category: category,
                                isSelected: category.id == selectedCategory,
                                selectedColor: Color(hex: category.color)
                            )
                            .onTapGesture {
                                selectedCategory = category.id
                            }
                        }
                        
                    }
                    .padding(.leading , leadingPadding)
                    
                }
            }
        case .empty : EmptyView()
        case .error(let error) : Text(error).font(
            .system(size: 14 , weight: .semibold)
        ).foregroundStyle(.red)
        default : EmptyView()
            
        }
            
    }
}
