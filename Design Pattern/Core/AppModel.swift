//
//  AppModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation
import Combine

struct AppState {
    var patterns: [PatternInfo] = PatternInfo.catalog
    var selectedPattern: DesignPattern?
    var factory = FactoryState()
    var strategy = StrategyState()
    var workflow = WorkflowState()
    var decorator = DecoratorState()

    var selectedPatternInfo: PatternInfo? {
        guard let selectedPattern else { return nil }
        return patterns.first(where: { $0.id == selectedPattern })
    }
}

enum AppIntent {
    case onAppear
    case selectPattern(DesignPattern)
    case factory(FactoryIntent)
    case strategy(StrategyIntent)
    case workflow(WorkflowIntent)
    case decorator(DecoratorIntent)
}

@MainActor
final class AppModel: ObservableObject {
    @Published private(set) var state = AppState()

    func send(_ intent: AppIntent) {
        switch intent {
        case .onAppear:
            if state.selectedPattern == nil {
                state.selectedPattern = .factory
            }
        case .selectPattern(let pattern):
            state.selectedPattern = pattern
        case .factory(let intent):
            FactoryReducer.reduce(state: &state.factory, intent: intent)
        case .strategy(let intent):
            StrategyReducer.reduce(state: &state.strategy, intent: intent)
        case .workflow(let intent):
            WorkflowReducer.reduce(state: &state.workflow, intent: intent)
        case .decorator(let intent):
            DecoratorReducer.reduce(state: &state.decorator, intent: intent)
        }
    }
}
