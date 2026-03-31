//
//  SheetHeaderView.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//

import SwiftUI

struct SheetHeaderView: View {
    let title: String
    let icon: String
    let action: () -> Void
    var body: some View {
        // Header with back button and centered title
        HStack {
            Button(action: { action() }) {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .glassEffect(.clear.interactive())
            }
            .buttonStyle(.plain)
            
            Spacer(minLength: 0)
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
            
            Spacer(minLength: 0)
            
            // Right-side placeholder to keep title centered
            Color.clear
                .frame(width: 36, height: 36)
        }
        .padding(.horizontal, 4)
        .padding(.top, 8)
    }
}


