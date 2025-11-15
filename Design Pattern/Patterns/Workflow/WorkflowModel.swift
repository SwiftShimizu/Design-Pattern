//
//  WorkflowModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

enum WorkflowPhase: String, CaseIterable, Identifiable {
    case idea
    case prototyping
    case release

    var id: String { rawValue }

    var title: String {
        switch self {
        case .idea: return "構想中"
        case .prototyping: return "試作中"
        case .release: return "リリース済み"
        }
    }

    var detail: String {
        switch self {
        case .idea:
            return "チームは要件を整理しながら方向性を決めています。"
        case .prototyping:
            return "ユーザー検証のためにインタラクティブなプロトタイプを構築中。"
        case .release:
            return "本番リリース後、改善リクエストを監視しています。"
        }
    }

    var next: WorkflowPhase? {
        switch self {
        case .idea: return .prototyping
        case .prototyping: return .release
        case .release: return nil
        }
    }

    var previous: WorkflowPhase? {
        switch self {
        case .idea: return nil
        case .prototyping: return .idea
        case .release: return .prototyping
        }
    }
}

struct WorkflowState {
    var currentPhase: WorkflowPhase = .idea
    var log: [String] = ["アイデアフェーズからスタート。"]
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
            guard let next = state.currentPhase.next else { return }
            state.currentPhase = next
            state.log.append("\(next.title)へ遷移しました。")
        case .rollback:
            guard let previous = state.currentPhase.previous else { return }
            state.currentPhase = previous
            state.log.append("\(previous.title)へ戻りました。")
        case .reset:
            state.currentPhase = .idea
            state.log.append("最初のフェーズにリセット。")
        }
    }
}
