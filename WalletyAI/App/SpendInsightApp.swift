//
//  SpendInsightApp.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

import SwiftUI
import CoreData

@main
struct SpendInsightApp: App {
    let appContainer = AppContainer(coreDataManaging: CoreDataStack())
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                appContainer: appContainer
            )
        }
    }
}



