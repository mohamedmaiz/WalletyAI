//
//  ScreenState.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//

public enum ViewState<T: Equatable>: Equatable {
    case idle
    case data(T)
    case empty
    case error(String)
    case loading
    
}


public extension ViewState {
    var isData: Bool {
            if case .data = self { return true }
            return false
        }
    
    var data: T? {
        if case .data(let value) = self {
            return value
        }
        return nil
    }
    
    var errorMessage: String? {
        if case let .error(message) = self {
            return message
        }
        return nil
    }
    
}

