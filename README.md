# SpendInsight

A modular iOS budgeting application built with SwiftUI, Core Data, and dependency injection, designed for scalability, maintainability, and clean feature isolation.

| Home  | Add Expense | Add Income |
|-------------------|------------|-------------|
| <img src="https://github.com/user-attachments/assets/864ac093-829b-4741-989e-59016cc12cf3" width="200"/> | <img src="https://github.com/user-attachments/assets/f300760e-e635-4158-820b-cfa3be1530be" width="200"/> | <img src="https://github.com/user-attachments/assets/894efc7f-ada2-4b5e-bc41-1232ea61a287" width="200"/> |
                                                                                                                                                                                                                                                                                                                                                                                          src="https://github.com/user-attachments/assets/7ad7d3e3-75e3-4907-a6e6-69517cad6227" /> |
## Project Summary

WalletyAI focuses on day-to-day expense tracking with a multi-module architecture.  
The project separates responsibilities into core packages, shared domain logic, and feature modules so each part can evolve independently and remain testable.

This codebase is structured to support:
- clear boundaries between Data, Domain, and Presentation layers
- reusable UI and utility packages
- Core Data persistence for local storage
- feature-level dependency composition
- preview-friendly development using mock dependencies

## Architecture

- Modular architecture (feature + core modules)
- Clean Architecture layering (Data -> Domain -> Presentation)
- MVVM in presentation modules
- Dependency Injection through module containers
- Local persistence with Core Data
- Swift Package Manager-based modules

## Project Structure

```text
SpendInsight
├── WalletyAI.xcodeproj
├── WalletyAI
│   ├── App
│   ├── Assets.xcassets
│   ├── CoreNetwork
│   ├── CorePersistence
│   ├── CoreUI
│   ├── CoreUtils
│   ├── Shared
│   └── Features
│       ├── Transactions
│       ├── Categories
│       ├── Onboarding
│       ├── Analysis
│       ├── Security
│       └── Settings
├── WalletyAITests
└── WalletyAIUITests
```

## Core Modules

- **CorePersistence**: Core Data stack and persistence utilities
- **CoreUI**: reusable SwiftUI components and design assets
- **CoreUtils**: shared utilities and view helpers
- **CoreNetwork**: networking abstractions/foundation
- **Shared**: domain entities, repository protocols, and shared use case contracts

## Feature Modules

- **Transactions**: transaction list, add/edit flows, dashboard, and insights components
- **Categories**: category management flow and create-category UI
- **Onboarding**: first-run onboarding flow and state
- **Analysis**: analysis feature scaffold
- **Security**: security feature scaffold
- **Settings**: settings feature scaffold

## Data & Persistence

- Uses `NSPersistentContainer` with a `SpendInsight` Core Data model
- Supports in-memory configuration for previews/tests
- Background context creation and safe context save API

## Development Principles

- SOLID-oriented boundaries across modules
- single-responsibility feature folders (DI, Data, Domain, Presentation, Preview)
- test targets per package/module
- scalable structure for adding future budgeting capabilities

## ⚙️ Requirements

> ⚠️ This project requires **Xcode 16+** and **iOS 16+** to run properly.

- Xcode 26 or later  
- iOS 26+
  
## Getting Started

1. Open `WalletyAI.xcodeproj` in Xcode.
2. Select the `WalletyAI` scheme.
3. Build and run on iOS Simulator.
4. Explore feature packages under `WalletyAI/Features`.

## Roadmap Ideas
- Add a recurring system for repeating transactions and income
- Complete scaffolded modules (`Analysis`, `Security`, `Settings`)
- Expand unit/integration coverage for feature and data layers
- Add CI workflows for build/test automation
- Introduce richer analytics and recurring budget insights

