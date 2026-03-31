//
//  DatePickerSheet.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//
import SwiftUI

public struct DatePickerSheet: View {
    @State private var draftDate: Date = Date()
    @Binding var date: Date
    @Binding var showingDatePicker: Bool
    public var body: some View {
        Screen(background: .primaryScreen) {
            VStack {
                DatePicker(
                    "",
                    selection: $draftDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)
                .preferredColorScheme(.dark)
                .labelsHidden()
                .padding(.horizontal)
                AppButton(title: "Done") {
                    date = draftDate; showingDatePicker = false
                }
                .frame(maxWidth: 200 , maxHeight: 40)
            }
            .onAppear { draftDate = date }
            .presentationDetents([.height(520), .large])
            .presentationDragIndicator(.visible)
        }
    }
}
