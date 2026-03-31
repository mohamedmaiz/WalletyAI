//
//  CategoryNameInput.swift
//  SpendInsight
//
//  Created by mac on 16/2/2026.
//

import SwiftUI

public struct GlassTextField: View {
    
    let placeholder: String
    let height: Double
    let lineLimit: Int
    @Binding var text: String
    
    init(placeholder: String, height: Double = 60, text: Binding<String> , lineLimit: Int = 1) {
        self.placeholder = placeholder
        self.height = height
        self._text = text
        self.lineLimit = lineLimit
    }
    public var body: some View {
        
        TextField(placeholder, text: $text)
            .lineLimit(lineLimit)
            .padding(.horizontal, 20)
            .frame(height: height)
            .glassEffect(.regular.tint(.white.opacity(0.05)).interactive())
    }
}

#Preview{
    Screen(background: .primaryScreen) {
        GlassTextField(placeholder: "e.g Summer Vacation", text: .constant(""))
            .padding()
    }
    
}
