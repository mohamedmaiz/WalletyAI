//
//  CategoryIconsView.swift
//  SpendInsight
//
//  Created by mac on 16/2/2026.
//

import SwiftUI

struct CategoryIconsView: View {
    @Binding var selectedIcon: CategoryType
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                
                ForEach(CategoryType.allCases) { category in
                    IconView(
                        selected: selectedIcon == category, category: category
                    )
                    .onTapGesture {
                        selectedIcon = category
                    }
                    .padding(.trailing , 4)
                }
            }
        }
        .frame(height: 160)
    }
}

private struct IconView: View {
    let selected: Bool
    let category: CategoryType
    
    var body: some View {
        Circle()
            .frame(width: 73 , height: 73)
            .foregroundStyle(
                selected ? .electricBlue.opacity(0.2) :  .white.opacity(0.04)
            )
            .overlay {
                Image(category.rawValue)
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(selected ? .electricBlue :  .white.opacity(0.6))
            }
            .overlay(
                Circle()
                    .stroke(
                        selected ? .electricBlue.opacity(0.4) :  Color.white.opacity(0.2),
                        lineWidth: selected ? 1 : 0.5
                    ) //
            )
    }
}

#Preview{
    Screen(background: .primaryScreen) {
        CategoryIconsView(selectedIcon: .constant(.home))
            .padding()
    }
    
}
