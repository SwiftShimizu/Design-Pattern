//
//  StrategyModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

enum StrategyType: String, CaseIterable, Identifiable {
    case ascending
    case descending
    case sumOfSquares

    var id: String { rawValue }

    var label: String {
        switch self {
        case .ascending: return "昇順ソート"
        case .descending: return "降順ソート"
        case .sumOfSquares: return "平方和"
        }
    }
}

struct StrategyState {
    let dataset: [Int] = [42, 7, 16, 3, 12]
    var selectedStrategy: StrategyType = .ascending
    var resultText: String = ""

    init() {
        resultText = StrategyReducer.describe(strategy: .ascending, data: dataset)
    }
}

enum StrategyIntent {
    case apply(StrategyType)
}

enum StrategyReducer {
    static func reduce(state: inout StrategyState, intent: StrategyIntent) {
        switch intent {
        case .apply(let strategy):
            state.selectedStrategy = strategy
            state.resultText = describe(strategy: strategy, data: state.dataset)
        }
    }

    static func describe(strategy: StrategyType, data: [Int]) -> String {
        switch strategy {
        case .ascending:
            return "昇順: \(data.sorted().map(String.init).joined(separator: ", "))"
        case .descending:
            return "降順: \(data.sorted(by: >).map(String.init).joined(separator: ", "))"
        case .sumOfSquares:
            let total = data.map { $0 * $0 }.reduce(0, +)
            return "平方和: \(total)"
        }
    }
}
