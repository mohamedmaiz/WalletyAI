//
//  NumericKeyboardView.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//

import SwiftUI


public enum KeyboardKey: Hashable {
    case number(String)
    case dot
    case delete
    
    var title: String {
        switch self {
        case .number(let value): return value
        case .dot: return "."
        case .delete: return ""
        }
    }
}

public struct NumericKeyboardView: View {
    
    var onKeyTap: (KeyboardKey) -> Void
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 40), count: 3)
    
    private let keys: [[KeyboardKey]] = [
        [.number("1"), .number("2"), .number("3")],
        [.number("4"), .number("5"), .number("6")],
        [.number("7"), .number("8"), .number("9")],
        [.dot, .number("0"), .delete]
    ]
    
    public var body: some View {
        VStack(spacing: 2) {
            ForEach(keys, id: \.self) { row in
                HStack(spacing: 60) {
                    ForEach(row, id: \.self) { key in
                        keyView(for: key)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

private extension NumericKeyboardView {
    
    
    @ViewBuilder
    func keyView(for key: KeyboardKey) -> some View {
        Button {
            onKeyTap(key)
        } label: {
            
            content(for: key)
                .frame(width: 65 , height: 65)
            
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    func content(for key: KeyboardKey) -> some View {
        switch key {
        case .number(let value):
            Text(value)
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
            
        case .dot:
            Text(".")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
            
        case .delete:
            Image(systemName: "delete.left")
                .font(.system(size: 22))
                .foregroundColor(.white)
        }
    }
    
}

struct KeyboardContainerView: View {
    
    @Binding var text: String
    
    var body: some View {
        NumericKeyboardView { key in
            handleKey(key)
        }
    }
    
    private func handleKey(_ key: KeyboardKey) {
        switch key {
        case .number(let value):
            // Handle leading zero scenarios and decimal precision
            if text.isEmpty {
                // Allow "0" or any digit as the first character
                text = value == "0" ? "0" : value
                return
            }
            
            if text == "0" {
                if value == "0" {
                    // Don't add another 0 when the amount is already exactly "0"
                    return
                } else {
                    // Replace leading "0" with the new non-zero digit
                    text = value
                    return
                }
            }
            
            // Enforce max two digits after the decimal point if present
            if let dotIndex = text.firstIndex(of: ".") {
                let fractionalStart = text.index(after: dotIndex)
                let fractionalCount = text[fractionalStart...].count
                if fractionalCount >= 2 {
                    return
                }
            }
            
            text.append(value)
            
        case .dot:
            if text.isEmpty {
                // Start decimal with "0."
                text = "0."
                return
            }
            if !text.contains(".") {
                text.append(".")
            }
        case .delete:
            if !text.isEmpty {
                text.removeLast()
            }
        }
    }
}


