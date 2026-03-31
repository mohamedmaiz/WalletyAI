//
//  BalanceHeaderView.swift
//  SpendInsight
//
//  Created by mac on 1/3/2026.
//

import SwiftUI
import Charts

struct BalancePoint: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
}

func calculateOpacity(value: Double , start: Double , range: Double) -> Double? {
    // If we didn't reach the threshold → full opacity
    guard value > start else {
        return nil
    }
    
    // Calculate progress
    let progress = (value - start) / range
    
    // Clamp between 0 and 1
    let clamped = min(max(progress, 0), 1)
    
    // Invert for opacity
    return Double(1 - clamped)
}

struct BalanceHeaderView: View {
    var balanceText: String = "$4,280.45"
    @Binding var offset: CGFloat
    @State private var chartOpacity: Double = 1.0
    @State private var segmentOpacity: Double = 1.0
    @State private var balanceOpacity: Double = 1.0
    @State private var headerActionsOpacity: Double = 0
    @State private var selectedRange: Range = .month
    
    
    
    // Chart data
    var data: [BalancePoint] = Self.sampleData
    
    // Gradient configuration for the line and fill
    var gradient: LinearGradient = LinearGradient(
        colors: [Color.blue, Color.purple],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            chart
            segmentPicker
                .padding(.bottom , 12 * segmentOpacity)
                .padding(.horizontal , 12)
        }
        .listRowBackground(Color.background)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .safeAreaPadding(.top)
        .background(
            Color.background.ignoresSafeArea()
        )
        .onChange(of: offset) {
            oldValue,
            newValue in
            
            headerActionsOpacity = 1 - ( calculateOpacity(
                value: newValue,
                start: -4,
                range: 80
            )  ?? 1 )
            
            segmentOpacity = calculateOpacity(
                value: newValue,
                start: 36,
                range: 160
            ) ?? 1
            
            chartOpacity = calculateOpacity(
                value: newValue,
                start: 36,
                range: 201
            ) ?? 1
            
            balanceOpacity = calculateOpacity(
                value: newValue,
                start: 36,
                range: 40
            ) ?? 1
            
        }
    }
    
    
    // MARK: Header Amount view
    private var header: some View {
        VStack(alignment: .center){
            HStack {
                // Left icon
                Image(systemName: "plus")
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44, alignment: .leading)
                    .contentShape(Rectangle())
                    .opacity(1 * headerActionsOpacity)
                
                Spacer()
                
                // Center balance text
                Text(balanceText)
                    .font(
                        .system(
                            size: 10 * balanceOpacity + 22,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    .foregroundStyle(.white)
                
                Spacer()
                
                // Right icon
                Image(systemName: "sparkles")
                    .font(.system(size: 22 ))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44, alignment: .trailing)
                    .contentShape(Rectangle())
                    .opacity(1 * headerActionsOpacity)
            }
            
            
            HStack(spacing: 6) {
                Image(systemName: "arrow.up.right")
//                    .font(.system(size: 12 * chartOpacity , weight: .semibold))
                Text("+3.2%")
                    .font(.system(size: 12 * chartOpacity , weight: .semibold))
                    .padding(.vertical, 6 * chartOpacity)
            }
            .padding(.horizontal, 10)
            .background(
                Capsule().fill(gradient)
                    .opacity(0.18)
            )
            .foregroundStyle(.green)
            .frame(height: 30 * chartOpacity)
        }
        .padding(.horizontal , 20)
    }
    
    
    //MARK: Chart view
    private var chart: some View {
        Chart {
            ForEach(data) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Amount", point.amount)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(gradient)
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                
                AreaMark(
                    x: .value("Date", point.date),
                    y: .value("Amount", point.amount)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    .linearGradient(
                        colors: [
                            Color.electricBlue.opacity(0.35),
                            Color.clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 7)) { _ in
                AxisGridLine().foregroundStyle(.clear)
                AxisTick().foregroundStyle(.clear)
                //                AxisValueLabel(format: .dateTime.weekday(.narrow))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: .automatic(desiredCount: 4)) { value in
                AxisGridLine().foregroundStyle(.clear)
                AxisTick().foregroundStyle(.clear)
                
            }
        }
        .frame(height: 120 * chartOpacity)
        .opacity(chartOpacity)
        
    }
    
    
    
    
    
    
    
}

// MARK: - Sample Data
extension BalanceHeaderView {
    static var sampleData: [BalancePoint] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).map { i in
            let date = calendar.date(byAdding: .day, value: -6 + i, to: today)!
            // Example variation; replace with your real values
            let base: Double = 3800
            let variation: Double = [1200, 1000, 0, 4000, 1000, 90, 1200][i].double
            return BalancePoint(date: date, amount: base + variation)
        }
    }
}

private extension Int {
    var double: Double { Double(self) }
}


enum Range: String, CaseIterable, Identifiable, Hashable {
    case day = "1D"
    case week = "1W"
    case month = "1M"
    case year = "1Y"
    case all = "ALL"
    var id: String { rawValue }
}



#Preview {
    BalanceHeaderView(
        balanceText: "$4,280.45",
        offset: .constant(0),
        data: BalanceHeaderView.sampleData,
        gradient: LinearGradient(colors: [Color.green, Color.blue], startPoint: .leading, endPoint: .trailing),
        
    )
}


extension BalanceHeaderView {
    
    private var segmentPicker : some View {
        HStack(spacing: 0) {
            ForEach(Range.allCases, id: \.self) { option in
                segmentView(option)
            }
        }
        .glassEffect(.clear.interactive())
    }
    
    private func segmentView(_ option: Range) -> some View {
        Text(option.rawValue)
            .font(.system(size: 14 * segmentOpacity, weight: .semibold))
            .frame(maxWidth: .infinity , maxHeight: 40 * segmentOpacity)
            .background(
                selectedRange == option
                ? Color.blueGray.opacity(0.4)
                : Color.clear
            )
            .background(
                RoundedRectangle(cornerRadius: 60)
                    .stroke( selectedRange == option
                             ?  .blueGray : .clear , lineWidth: 1.5)
            )
            .foregroundColor(
                selectedRange == option
                ? .white
                : .blueGray
            )
            .clipShape(RoundedRectangle(cornerRadius: 60))
            .onTapGesture {
                selectedRange = option
            }
    }
}

