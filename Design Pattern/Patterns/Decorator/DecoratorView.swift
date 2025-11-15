//
//  DecoratorView.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import SwiftUI

struct DecoratorDemoView: View {
    let state: DecoratorState
    let send: (DecoratorIntent) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("プレビュー")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                decoratorPreview
            }

            VStack(alignment: .leading, spacing: 8) {
                ForEach(DecoratorLayer.allCases) { layer in
                    Toggle(
                        layer.label,
                        isOn: Binding(
                            get: { state.activeLayers.contains(layer) },
                            set: { send(.toggle(layer, $0)) }
                        )
                    )
                }
            }

            HStack {
                Text(String(format: "合計 ¥%.0f", state.totalPrice))
                    .font(.headline)
                Spacer()
                Button("装飾をクリア") {
                    send(.reset)
                }
            }

            Text(state.note)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(.thinMaterial))
    }

    @ViewBuilder
    private var decoratorPreview: some View {
        let hasBorder = state.activeLayers.contains(.border)
        let hasShadow = state.activeLayers.contains(.shadow)
        let hasGlow = state.activeLayers.contains(.glow)
        let hasBadge = state.activeLayers.contains(.badge)

        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.purple.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(hasBorder ? Color.purple : Color.clear, lineWidth: hasBorder ? 4 : 0)
                )
                .shadow(color: hasShadow ? .black.opacity(0.3) : .clear, radius: hasShadow ? 10 : 0)
                .overlay(
                    Text(state.summary)
                        .padding()
                        .multilineTextAlignment(.leading),
                    alignment: .center
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(hasGlow ? Color.purple.opacity(0.8) : Color.clear, lineWidth: hasGlow ? 2 : 0)
                        .blur(radius: hasGlow ? 4 : 0)
                )

            if hasBadge {
                Text("★")
                    .padding(8)
                    .background(Circle().fill(Color.orange))
                    .offset(x: 12, y: -12)
            }
        }
        .frame(height: 150)
    }
}
