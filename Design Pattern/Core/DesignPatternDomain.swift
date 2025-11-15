//
//  DesignPatternDomain.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

enum DesignPattern: String, CaseIterable, Identifiable {
    case factory = "Factory"
    case strategy = "Strategy"
    case state = "State"
    case decorator = "Decorator"

    var id: String { rawValue }
}

struct PatternInfo: Identifiable {
    let id: DesignPattern
    let headline: String
    let description: String

    static let catalog: [PatternInfo] = [
        PatternInfo(
            id: .factory,
            headline: "生成の責務を切り離す",
            description: "入力条件に応じて適切な製品を生み出すFactoryパターンの簡易デモ。"
        ),
        PatternInfo(
            id: .strategy,
            headline: "アルゴリズムの差し替え",
            description: "同じデータを異なるStrategyで処理し、結果の違いを比較します。"
        ),
        PatternInfo(
            id: .state,
            headline: "Stateによる振る舞いの分離",
            description: "状態遷移に応じて利用できるアクションとUIを変化させます。"
        ),
        PatternInfo(
            id: .decorator,
            headline: "機能追加の重ね掛け",
            description: "Decoratorでカードに装飾を積み上げコストと見た目の変化を可視化。"
        )
    ]
}
