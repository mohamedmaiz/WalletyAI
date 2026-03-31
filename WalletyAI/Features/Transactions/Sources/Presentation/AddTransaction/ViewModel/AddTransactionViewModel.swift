//
//  TransactionViewModel.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//
import Combine
import Foundation

class AddTransactionViewModel: ObservableObject{
    let insertTransactionUseCase: InsertTransactionUseCaseProtocol
    let fetchCategoriesUseCase: FetchCategoriesUseCase
    private let insertTransactionValidator = InsertTransactionValidator()
    
    
    init(
        insertTransactionUseCase: InsertTransactionUseCaseProtocol,
        fetchCategoriesUseCase: FetchCategoriesUseCase
    ) {
        self.insertTransactionUseCase = insertTransactionUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        fetchCategories()
    }
    
    
    @Published var insertTransactionState: ViewState<Bool> = .idle
    @Published var categoriesState: ViewState<[Category]> = .idle
    
    @Published var step: Int = 0
    @Published var transactionType: TransactionType = .expense
    @Published var amount = ""
    @Published var selectedCategory: UUID?
    @Published var title: String = ""
    @Published var notes: String = ""
    @Published var date: Date = Date()
    @Published var recurring: RecurringRule? = nil
    
    // Parsed amount helper
    private var parsedAmount: Double {
        Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }

    
}

extension AddTransactionViewModel {
    
    func goToDetailsView() {
        if parsedAmount == 0 {
            insertTransactionState = .error("Please enter an amount")
            return
        }
        
        insertTransactionState = .idle
        step = 1
    }
    
    func backToAmountView() {
        step = 0
    }
    
    func fetchCategories() {
        categoriesState = .loading
        do{
            let data = try fetchCategoriesUseCase.execute()
            
            if (data?.count ?? 0) > 0{
                categoriesState = .data(data!)
            } else {
                categoriesState = .empty
            }
        }
        catch {
            categoriesState = .error(error.localizedDescription)
        }
    }
    
    func insertTransaction(){
        
        if let error = insertTransactionValidator.Validate(
            title: title,
            amount: parsedAmount,
            date: date
        ) {
            insertTransactionState = .error(error)
            return
        }
        
        do{
            insertTransactionState = .loading
           _ = try insertTransactionUseCase.execute(
                title: title,
                description: notes,
                amount: parsedAmount,
                type: transactionType,
                parent: selectedCategory,
                date: date
            )
            insertTransactionState = .data(true)
        }catch{
            insertTransactionState = .error(error.localizedDescription)
        }
    }
    
   
}
// MARK: - RecurringRule Model
struct RecurringRule: Equatable {
    enum Frequency: String { case daily, weekly, monthly, yearly }
    enum Ends: Equatable { case never, onDate(Date), afterCount(Int) }

    var frequency: Frequency
    var weekdays: Set<Int> = [] // 1...7 (Sun=1)
    var ends: Ends = .never
}

extension RecurringRule {
    var summary: String {
        switch frequency {
        case .daily: return "every day"
        case .weekly:
            if weekdays.isEmpty { return "weekly" }
            let symbols = Calendar.current.weekdaySymbols
            let names = weekdays.sorted().map { symbols[$0-1] }
            if names.count == 1 { return "every \(names[0])" }
            return "weekly on " + names.joined(separator: ", ")
        case .monthly: return "monthly"
        case .yearly: return "yearly"
        }
    }
}

