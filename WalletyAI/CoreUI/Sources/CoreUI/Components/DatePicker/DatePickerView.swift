//
//  DatePickerView.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//
import SwiftUI

public struct DatePickerView: View {
    @Binding var date: Date
    @Binding var showingDatePicker: Bool
    public var body: some View {
        Button(action: { showingDatePicker = true }) {
            HStack(spacing: 12) {
                Image(systemName: "calendar")
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 18, weight: .semibold))
                Text(date, style: .date)
                    .foregroundStyle(.primary)
                Text(", ")
                    .foregroundStyle(.primary)
                Text(date, style: .time)
                    .foregroundStyle(.primary)
                Spacer(minLength: 0)
                Image(systemName: "chevron.down")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .glassEffect(
                .regular.tint(.white.opacity(0.05)).interactive()
            )
        }
        .buttonStyle(.plain)
        .padding(.bottom , 30)
    }
}
