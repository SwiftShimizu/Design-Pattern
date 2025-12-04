//
//  WorkflowView.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import SwiftUI

struct WorkflowDemoView: View {
    let state: WorkflowState
    let send: (WorkflowIntent) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(state.currentPhase.title)
                .font(.title2)
                .bold()
            Text(state.currentPhase.detail)
                .foregroundStyle(.secondary)

            HStack {
                Button("戻る") {
                    send(.rollback)
                }
                .disabled(!state.currentPhase.canRollback)

                Button("進む") {
                    send(.advance)
                }
                .disabled(!state.currentPhase.canAdvance)

                Spacer()

                Button("リセット") {
                    send(.reset)
                }
                .buttonStyle(.bordered)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("履歴")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                ForEach(Array(state.log.enumerated()), id: \.offset) { entry in
                    Text("• \(entry.element)")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(.thinMaterial))
    }
}
