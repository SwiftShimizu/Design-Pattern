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
                ForEach(StrategyType.allCases) { strategy in
                    Button(strategy.label) {
                        send(.apply(strategy))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(strategy == state.selectedStrategy ? .accentColor : .secondary)
                    .opacity(strategy == state.selectedStrategy ? 1 : 0.7)
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
