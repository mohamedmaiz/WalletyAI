//
//  DashboardScreen.swift
//  SpendInsight
//
//  Created by mac on 1/3/2026.
//

import SwiftUI

struct DashboardScreen: View {
    @StateObject var vm: TransactionListViewModel
    @State private var offset: CGFloat = 0
    
    let showAddTransactionSheet: () -> Void
    let showInsightSheet: () -> Void
    let onEditTransaction: (Transaction) -> Void
    let onDeleteTransaction: (Transaction) -> Void
    
    var body: some View {
        Screen(background: .primaryScreen) {
            
            ZStack(alignment: .top){
                Color.background.ignoresSafeArea()
                List{
                    Color.clear.frame(height : 400)
                        .listRowBackground(Color.background)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    
                    TransactionListView(
                        vm: vm,
                        onEditTransaction: onEditTransaction,
                        onDeleteTransaction: onDeleteTransaction
                    )
                    .padding(.horizontal , 8)
                    
                    //                SmartInsightsView()
                    
                }
                .scrollIndicators(.hidden)
                .refreshable(action: {
                    
                })
                .onScrollGeometryChange(for: CGFloat.self) { geometry in
                    geometry.contentOffset.y
                } action: { oldValue, newValue in
                    offset = newValue
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .listRowInsets(EdgeInsets())
                
                VStack{
                    BalanceHeaderView(offset: $offset)
                    QuickActionsRow(
                        addTransactionAction: showAddTransactionSheet,
                        aiInsightsAction: showInsightSheet,
                        offset: $offset
                    )
                }
                .background(Color.background)
            }
            
            
            
        }
        
        
        
        
    }
}

fileprivate struct QuickActionsRow: View {
    let addTransactionAction: () -> Void
    let aiInsightsAction: () -> Void
    @Binding var offset: CGFloat
    @State private var opacity: Double = 1.0
    
    var body: some View {
        
        HStack(spacing: 22) {
            // Transfer (inactive)
            QuickActionButton(
                opacity: $opacity,
                systemImage: "arrow.left.arrow.right",
                title: "Transfer",
                active: false,
                color: .successGreen,
                action: {}
            )
            .opacity(0.5)
            
            // Add Transaction
            QuickActionButton(
                opacity: $opacity,
                systemImage: "plus.circle.fill",
                title: "Add",
                active: true,
                color: .successGreen,
                action: addTransactionAction
            )
            
            // AI Insights
            QuickActionButton(
                opacity: $opacity,
                systemImage: "sparkles",
                title: "Insights",
                active: true,
                color: .darkBlueViolet,
                action: aiInsightsAction
            )
        }
        .opacity(opacity)
        .onChange(of: offset) { oldValue, newValue in
            
            opacity = calculateOpacity(value: newValue, start: -44, range: 80) ?? 1
            
        }
        .listRowBackground(Color.background)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .frame(height: 80 * opacity)
        
        
    }
    
    
}

fileprivate struct QuickActionButton: View {
    @Binding var opacity: Double
    let systemImage: String
    let title: String
    let active: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: { if active { action() } }) {
            VStack(spacing: 8) {
                Image(systemName: systemImage)
                    .renderingMode(.template)
                    .foregroundStyle(active ? color : Color.secondary)
                    .frame(width: 40 * opacity, height: 40 * opacity)
                    .background(
                        Circle()
                            .fill(active ? color.opacity(0.12) : Color.secondary.opacity(0.08))
                    )
                    .opacity(opacity)
                
                Text(title)
                    .font(.system(size: 12 * opacity , weight: .semibold))
                    .foregroundStyle(active ? Color.white : Color.secondary)
                    .opacity(opacity)
            }
            .frame(
                maxWidth: 60 * opacity ,
                maxHeight: 60 * opacity
            )
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.white.opacity(0.08))
            )
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(.blueGray.opacity(0.5))
            )
        }
        .buttonStyle(.plain)
        .disabled(!active)
    }
}

fileprivate struct SmartInsightsView: View {
    // Sample insights; replace with real data later
    private let insights: [Insight] = [
        Insight(icon: "leaf.fill", iconColor: .green, title: "You spent 15% less on dining this week compared to last.", subtitle: "Keep it up!"),
        Insight(icon: "cart.fill", iconColor: .purple, title: "Groceries up 8% this month.", subtitle: "Consider switching to a budget list."),
        Insight(icon: "fuelpump.fill", iconColor: .orange, title: "Fuel spending down 12%.", subtitle: "Fewer trips saved you $18."),
        Insight(icon: "gift.fill", iconColor: .pink, title: "Subscriptions renew next week.", subtitle: "Review to avoid surprises."),
    ]
    
    private let cardWidth: CGFloat = 300
    private let cardHeight: CGFloat = 110
    private let spacing: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundStyle(Color.electricBlue)
                Text("Smart Insights")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
            }
            
            GeometryReader { outer in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(insights) { insight in
                            GeometryReader { cardGeo in
                                let midX = cardGeo.frame(in: .named("insightsScroll")).midX
                                let center = outer.frame(in: .named("insightsScroll")).midX
                                let distance = abs(midX - center)
                                let maxDistance = (cardWidth + spacing)
                                let t = max(0, min(1, distance / maxDistance))
                                let scale = 1.0 - (0.12 * t) // 1.0 center -> 0.88 sides
                                let opacity = 1.0 - (0.6 * t) // 1.0 center -> 0.4 sides
                                
                                InsightCard(insight: insight)
                                    .frame(width: cardWidth, height: cardHeight)
                                    .scaleEffect(scale)
                                    .opacity(opacity)
                                    .animation(.easeOut(duration: 0.2), value: distance)
                                    .padding(.vertical, 8)
                            }
                            .frame(width: cardWidth, height: cardHeight)
                            .scrollTargetLayout()
                        }
                    }
                    
                    .padding(.vertical, 4)
                }
                .coordinateSpace(name: "insightsScroll")
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .frame(height: 160)
        .listRowBackground(Color.background)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .padding(.leading , 12)
        .padding(.vertical, 8)
    }
}

fileprivate struct InsightCard: View {
    let insight: Insight
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: insight.icon)
                .foregroundStyle(insight.iconColor)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(insight.title)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .lineLimit(3)
                if let subtitle = insight.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.6))
                        .lineLimit(2)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.white.opacity(0.05))
        )
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.blueGray.opacity(0.4))
        )
    }
}

fileprivate struct Insight: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let title: String
    var subtitle: String? = nil
}

#Preview {
    let appContainer = AppContainer.preview
    
    DashboardScreen(
        vm: appContainer.makeTransactionFeature().makeTransactionVM(),
        showAddTransactionSheet: {},
        showInsightSheet: {},
        onEditTransaction: {_ in},
        onDeleteTransaction: {_ in}
    )
    
}
