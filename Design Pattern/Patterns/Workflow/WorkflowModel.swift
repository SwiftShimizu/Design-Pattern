//
//  WorkflowModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

protocol WorkflowPhase {
    var title: String { get }
    var detail: String { get }
    var canAdvance: Bool { get }
    var canRollback: Bool { get }
    func advance(context: inout WorkflowState)
    func rollback(context: inout WorkflowState)
}

struct IdeaPhase: WorkflowPhase {
    var title: String { "構想中" }
    var detail: String { "チームは要件を整理しながら方向性を決めています。" }
    var canAdvance: Bool { true }
    var canRollback: Bool { false }

    func advance(context: inout WorkflowState) {
        context.currentPhase = PrototypingPhase()
        context.log.append("試作中へ遷移しました。")
    }

    func rollback(context: inout WorkflowState) {
        // 先頭フェーズなので何もしない
    }
}

struct PrototypingPhase: WorkflowPhase {
    var title: String { "試作中" }
    var detail: String { "ユーザー検証のためにインタラクティブなプロトタイプを構築中。" }
    var canAdvance: Bool { true }
    var canRollback: Bool { true }

    func advance(context: inout WorkflowState) {
        context.currentPhase = ReleasePhase()
        context.log.append("リリース済みへ遷移しました。")
    }

    func rollback(context: inout WorkflowState) {
        context.currentPhase = IdeaPhase()
        context.log.append("構想中へ戻りました。")
    }
}

struct ReleasePhase: WorkflowPhase {
    var title: String { "リリース済み" }
    var detail: String { "本番リリース後、改善リクエストを監視しています。" }
    var canAdvance: Bool { false }
    var canRollback: Bool { true }

    func advance(context: inout WorkflowState) {
        // 終端フェーズなので遷移しない
    }

    func rollback(context: inout WorkflowState) {
        context.currentPhase = PrototypingPhase()
        context.log.append("試作中へ戻りました。")
    }
}

struct WorkflowState {
    var currentPhase: any WorkflowPhase
    var log: [String]

    init(
        currentPhase: (any WorkflowPhase)? = nil,
        log: [String] = ["アイデアフェーズからスタート。"]
    ) {
        self.currentPhase = currentPhase ?? IdeaPhase()
        self.log = log
    }

    mutating func reset() {
        currentPhase = IdeaPhase()
        log.append("最初のフェーズにリセット。")
    }
}

enum WorkflowIntent {
    case advance
    case rollback
    case reset
}

enum WorkflowReducer {
    static func reduce(state: inout WorkflowState, intent: WorkflowIntent) {
        switch intent {
        case .advance:
            guard state.currentPhase.canAdvance else { return }
            state.currentPhase.advance(context: &state)
        case .rollback:
            guard state.currentPhase.canRollback else { return }
            state.currentPhase.rollback(context: &state)
        case .reset:
            state.reset()
        }
    }
}
