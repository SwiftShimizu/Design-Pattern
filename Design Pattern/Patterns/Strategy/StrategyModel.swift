//
//  StrategyModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

protocol DatasetStrategy {
    var id: String { get }
    var label: String { get }
    func describe(_ data: [Int]) -> String
}

struct AscendingStrategy: DatasetStrategy {
    let id = "ascending"
    let label = "昇順ソート"

    func describe(_ data: [Int]) -> String {
        "昇順: \(data.sorted().map(String.init).joined(separator: ", "))"
    }
}

struct DescendingStrategy: DatasetStrategy {
    let id = "descending"
    let label = "降順ソート"

    func describe(_ data: [Int]) -> String {
        "降順: \(data.sorted(by: >).map(String.init).joined(separator: ", "))"
    }
}

struct SumOfSquaresStrategy: DatasetStrategy {
    let id = "sumOfSquares"
    let label = "平方和"

    func describe(_ data: [Int]) -> String {
        let total = data.map { $0 * $0 }.reduce(0, +)
        return "平方和: \(total)"
    }
}

enum StrategyLibrary {
    static let strategies: [any DatasetStrategy] = [
        AscendingStrategy(),
        DescendingStrategy(),
        SumOfSquaresStrategy()
    ]

    static let fallback: any DatasetStrategy = AscendingStrategy()
}

struct StrategyState {
    let dataset: [Int]
    let availableStrategies: [any DatasetStrategy]
    var selectedStrategyID: String
    var resultText: String

    init(
        dataset: [Int] = [42, 7, 16, 3, 12],
        strategies: [any DatasetStrategy] = StrategyLibrary.strategies
    ) {
        self.dataset = dataset
        self.availableStrategies = strategies
        let initial = strategies.first ?? StrategyLibrary.fallback
        self.selectedStrategyID = initial.id
        self.resultText = initial.describe(dataset)
    }

    func strategy(withID id: String) -> any DatasetStrategy {
        availableStrategies.first(where: { $0.id == id }) ?? availableStrategies.first ?? StrategyLibrary.fallback
    }
}

enum StrategyIntent {
    case apply(String)
}

enum StrategyReducer {
    static func reduce(state: inout StrategyState, intent: StrategyIntent) {
        switch intent {
        case .apply(let strategyID):
            state.selectedStrategyID = strategyID
            let strategy = state.strategy(withID: strategyID)
            state.resultText = strategy.describe(state.dataset)
        }
    }
}
