//
//  CategoryColorsView.swift
//  SpendInsight
//
//  Created by mac on 16/2/2026.
//

import SwiftUI

enum CategoryColor: CaseIterable, Identifiable {
    case blue
    case pink
    case green
    case orange
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .blue: return .electricBlue
        case .pink: return .pink
        case .green: return .green
        case .orange: return .orange
        }
    }
}


struct ColorSelectorView: View {
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Predefined colors
            ForEach(CategoryColor.allCases) { item in
                ColorCircle(
                    color: item.color,
                    isSelected: selectedColor == item.color
                ) {
                    selectedColor = item.color
                }
            }
            
            ColorPicker("", selection: $selectedColor)
                .labelsHidden()
                .scaleEffect(2.3)
                .padding(.leading , 16)
            
        }
    }
}




struct ColorCircle: View {
    
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 60, height: 60)
                .overlay(
                    Circle()
                        .stroke(
                            isSelected ? Color.electricBlue : Color.clear,
                            lineWidth: 3
                        )
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .scaleEffect(isSelected ? 1.1 : 1)
                .animation(.spring(response: 0.3), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}


#Preview{
    Screen(background: .primaryScreen) {
        ColorSelectorView(selectedColor: .constant(.blue))
            .padding()
    }
    
}
