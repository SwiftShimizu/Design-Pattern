//
//  StrategyView.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import SwiftUI

struct StrategyDemoView: View {
    let state: StrategyState
    let send: (StrategyIntent) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("データセット: \(state.dataset.map(String.init).joined(separator: ", "))")
                .font(.subheadline)

            HStack {
                ForEach(state.availableStrategies, id: \.id) { strategy in
                    Button(strategy.label) {
                        send(.apply(strategy.id))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(strategy.id == state.selectedStrategyID ? .accentColor : .secondary)
                    .opacity(strategy.id == state.selectedStrategyID ? 1 : 0.7)
                }
            }

            Text(state.resultText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue.opacity(0.1)))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(.thinMaterial))
    }
}
