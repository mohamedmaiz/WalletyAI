//
//  TransactionDetailsSection.swift
//  SpendInsight
//
//  Created by mac on 23/2/2026.
//

import SwiftUI

struct TransactionDetailsSection: View {
    @State private var showingDatePicker: Bool = false
    @FocusState private var isFocused: Bool
    
    @State private var showingRecurringSheet: Bool = false
    @State private var recurringSummary: String? = nil
    
    @Binding var transactionType: TransactionType
    let backToAmount: () -> Void
    @Binding var title: String
    @Binding var notes: String
    @Binding var date: Date
    @Binding var recurring: RecurringRule?
    @Binding var state : ViewState<Bool>
    let insertTransaction: () -> Void
    
    var body: some View {
        Screen(
            background: transactionType == .expense ? .expenseScreen : .incomeScreen
        ){
            VStack(alignment: .leading){
                
                SheetHeaderView(
                    title: "Transaction Details",
                    icon: "chevron.left",
                    action: backToAmount
                )
                .padding(.bottom, 50)
                
                Text("WHAT WAS IT FOR?")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.bottom , 6)
                
                TextField(
                    "",
                    text: $title,
                    prompt: Text("e.g. Coffe..")
                        .foregroundStyle(.blueGray.opacity(0.8))
                )
                .submitLabel(.done)
                .focused($isFocused)
                .frame(maxWidth: .infinity , minHeight: 60 , maxHeight: 60)
                .foregroundStyle(.white)
                .padding(.horizontal , 16)
                .background(.white.opacity(0.05))
                .cornerRadius(30)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.1))
                }
                
                Text("NOTES")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.top , 20)
                    .padding(.bottom , 6)
                
                TextField("", text: $notes ,prompt: Text("e.g. buying coffee for friends").foregroundStyle(.blueGray.opacity(0.8)) , axis: .vertical)
                    .submitLabel(.done)
                    .focused($isFocused)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity , minHeight: 120 , maxHeight: 120)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                    .padding(.horizontal , 16)
                    .background(.white.opacity(0.05))
                    .cornerRadius(30)
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.white.opacity(0.1))
                    }
                
                Text("DATE & TIME")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.top , 20)
                    .padding(.bottom , 6)
                DatePickerView(
                    date: $date,
                    showingDatePicker: $showingDatePicker
                )
                
                Button {
                    showingRecurringSheet = true
                } label: {
                    HStack {
                        Text("Recurring")
                        Spacer()
                        if let summary = recurringSummary {
                            Text(summary)
                                .lineLimit(1)
                                .foregroundStyle(.blueGray)
                        } else {
                            Text("None")
                                .foregroundStyle(.blueGray.opacity(0.6))
                        }
                        Image(systemName: "chevron.right")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.blueGray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.white.opacity(0.05))
                    .cornerRadius(30)
                }
                .padding(.top, 20)
                
                Spacer()
                if let errorMessage = state.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 4)
                }
                AppButton(title: "Save Transaction") {
                    insertTransaction()
                }
                
            }
            .padding(.horizontal , 20)
            .safeAreaPadding(.vertical)
            .onChange(of: recurring) { newValue in
                recurringSummary = newValue?.summary
            }
            .onAppear {
                recurringSummary = recurring?.summary
            }
            
        }
        .onTapGesture {
            isFocused = false
        }
        .sheet(isPresented: $showingDatePicker) {
            DatePickerSheet(date: $date, showingDatePicker: $showingDatePicker)
        }
        .sheet(isPresented: $showingRecurringSheet) {
            RecurringPickerSheet(
                initialDate: date,
                onDone: { rule in
                    recurring = rule
                    recurringSummary = rule.summary
                    showingRecurringSheet = false
                },
                onCancel: {
                    showingRecurringSheet = false
                }
            )
            .presentationBackground(.clear)
        }
        
        
    }
}



private struct RecurringPickerSheet: View {
    enum Frequency: String, CaseIterable, Identifiable { case daily = "Daily", weekly = "Weekly", monthly = "Monthly", yearly = "Yearly"; var id: String { rawValue } }
    enum Ends: String, CaseIterable, Identifiable { case never = "Never", onDate = "On date", afterCount = "After count"; var id: String { rawValue } }

    let initialDate: Date
    let onDone: (_ rule: RecurringRule) -> Void
    let onCancel: () -> Void

    @State private var frequency: Frequency = .weekly
    @State private var selectedWeekdays: Set<Int> = [] // 1...7 (Sun=1)
    @State private var ends: Ends = .never
    @State private var endDate: Date = Date()
    @State private var count: Int = 10

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recurring")
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
                Button("Cancel", action: onCancel)
                    .foregroundStyle(.secondary)
                Button("Done") {
                    onDone(buildRule())
                }
                .foregroundStyle(Color.electricBlue)
            }
            .padding(.top, 8)
            // Frequency
            Text("Frequency")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.blueGray)
            Picker("Frequency", selection: $frequency) {
                ForEach(Frequency.allCases) { f in
                    Text(f.rawValue).tag(f)
                }
            }
            .pickerStyle(.segmented)
            if frequency == .weekly { WeekdayGrid(selected: $selectedWeekdays) }
            Text("Ends")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.blueGray)
            Picker("Ends", selection: $ends) {
                ForEach(Ends.allCases) { e in
                    Text(e.rawValue).tag(e)
                }
            }
            .pickerStyle(.segmented)
            switch ends {
            case .never: EmptyView()
            case .onDate:
                DatePicker("End date", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            case .afterCount:
                HStack {
                    Text("Occurrences")
                        .foregroundStyle(.white)
                    Spacer()
                    Stepper(value: $count, in: 1...100) { Text("\(count)").foregroundStyle(.white) }
                        .labelsHidden()
                }
                .padding(.vertical, 4)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(.ultraThinMaterial.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 16)
    }

    private func buildRule() -> RecurringRule {
        let freq: RecurringRule.Frequency
        switch frequency {
        case .daily: freq = .daily
        case .weekly: freq = .weekly
        case .monthly: freq = .monthly
        case .yearly: freq = .yearly
        }
        var rule = RecurringRule(frequency: freq)
        if freq == .weekly { rule.weekdays = selectedWeekdays }
        switch ends {
        case .never: rule.ends = .never
        case .onDate: rule.ends = .onDate(endDate)
        case .afterCount: rule.ends = .afterCount(count)
        }
        return rule
    }
}



#Preview {
    TransactionDetailsSection(
        transactionType: .constant(.expense),
        backToAmount: {},
        title: .constant(""),
        notes: .constant(""),
        date: .constant(Date()),
        recurring: .constant(nil),
        state: .constant(.idle),
        insertTransaction: {}
    )
}

private struct WeekdayGrid: View {
    @Binding var selected: Set<Int>
    private let symbols = Calendar.current.veryShortWeekdaySymbols // S M T W T F S
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...7, id: \.self) { idx in
                let isOn = selected.contains(idx)
                Button(action: {
                    if isOn { selected.remove(idx) } else { selected.insert(idx) }
                }) {
                    Text(symbols[idx-1])
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isOn ? Color.black : Color.white)
                        .frame(width: 36, height: 36)
                        .background(isOn ? Color.electricBlue : Color.white.opacity(0.08))
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 6)
    }
}
