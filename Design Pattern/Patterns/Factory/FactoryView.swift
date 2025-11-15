//
//  FactoryView.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import SwiftUI

struct FactoryDemoView: View {
    let state: FactoryState
    let send: (FactoryIntent) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ニーズに合わせて製品を生成します。")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            TextField(
                "欲しい特徴 (例: \"音声認識\")",
                text: Binding(
                    get: { state.requestedFeature },
                    set: { send(.updateFeature($0)) }
                )
            )
            .textFieldStyle(.roundedBorder)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(FactoryProduct.allCases) { product in
                        Button {
                            send(.build(product))
                        } label: {
                            VStack {
                                Text(product.emoji)
                                    .font(.largeTitle)
                                Text(product.label)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .frame(width: 120, height: 120)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(product == state.selectedProduct ? Color.accentColor.opacity(0.2) : Color.secondary.opacity(0.1))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(state.currentProduct.name)
                        .font(.headline)
                    Spacer()
                    if !state.lastBuildStamp.isEmpty {
                        Text(state.lastBuildStamp)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Text(state.currentProduct.detail())
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).stroke(.secondary.opacity(0.4)))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(.thinMaterial))
    }
}
