//
//  MainTabView.swift
//  SpendInsight
//
//  Created by mac on 19/2/2026.
//

import SwiftUI

enum AppTab: CaseIterable {
    case dashboard
    case analytics
    case category
    case settings
    case action
    
    var icon: String {
        switch self {
        case .dashboard: return ""
        case .analytics: return ""
        case .category: return ""
        case .settings: return ""
        case .action: return ""
        }
    }
}
struct MainTabView: View {
    
    let appContainer: AppContainer
    
    @State private var selectedTab: AppTab = .dashboard
    @State private var showSheet: Bool = false
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
        
    }
    
    var body: some View {
        TabView(selection: $selectedTab){
            Tab(
                value: AppTab.dashboard
            )            {
                TransactionCoordinator(
                    container: appContainer.makeTransactionFeature()
                )
                
            } label: {
                Image("dashboard")
                    .renderingMode(.template)
                Text("Dashboard")
            }
            
            
            Tab( value: AppTab.analytics) {
                CategoriesScreen(
                    vm: appContainer.makeCategoryFeature().makeCategoriesVM()
                )
            } label: {
                Image("analytics")
                    .renderingMode(.template)
                Text("Analytics")
            }
            Tab( value: AppTab.category) {
                Color.background.ignoresSafeArea()
            } label: {
                Image("categories")
                    .renderingMode(.template)
                Text("Categories")
            }
            Tab( value: AppTab.category) {
                Color.background.ignoresSafeArea()
            } label: {
                Image("settings")
                    .renderingMode(.template)
                Text("Settings")
            }
            
            Tab(
                "Add",
                systemImage: "plus",
                value: AppTab.action ,
                role: .search
            ) {
                
            }
        }
        .tint(.electricBlue)
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == .action {
                showSheet = true
                selectedTab = .dashboard   // Return to previous tab
            }
        }
        .sheet(isPresented: $showSheet) {
            AddTransactionSheet(vm: appContainer
                .makeTransactionFeature().makeAddTransactionVM())
        }
        
    }
}





#Preview {
    MainTabView(appContainer: AppContainer.preview)
}

