//
//  ContentView.swift
//  Design Pattern
//
//  Created by 志水拓哉 on 2025/11/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = AppModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                header
                patternPicker
                if let info = model.state.selectedPatternInfo {
                    Text(info.headline)
                        .font(.headline)
                    Text(info.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                patternBody
                Spacer(minLength: 0)
            }
            .padding()
            .navigationTitle("Design Patterns + MVI")
        }
        .onAppear {
            model.send(.onAppear)
        }
    }

    private var selectedPatternBinding: Binding<DesignPattern> {
        Binding(
            get: { model.state.selectedPattern ?? .factory },
            set: { model.send(.selectPattern($0)) }
        )
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("デザインパターン学習")
                .font(.largeTitle.bold())
            Text("MVI構成で各パターンのUIとロジックを分離しています。")
                .foregroundStyle(.secondary)
        }
    }

    private var patternPicker: some View {
        Picker("デザインパターン", selection: selectedPatternBinding) {
            ForEach(model.state.patterns) { pattern in
                Text(pattern.id.rawValue)
                    .tag(pattern.id)
            }
        }
        .pickerStyle(.segmented)
    }

    @ViewBuilder
    private var patternBody: some View {
        switch model.state.selectedPattern ?? .factory {
        case .factory:
            FactoryDemoView(
                state: model.state.factory,
                send: { model.send(.factory($0)) }
            )
        case .strategy:
            StrategyDemoView(
                state: model.state.strategy,
                send: { model.send(.strategy($0)) }
            )
        case .state:
            WorkflowDemoView(
                state: model.state.workflow,
                send: { model.send(.workflow($0)) }
            )
        case .decorator:
            DecoratorDemoView(
                state: model.state.decorator,
                send: { model.send(.decorator($0)) }
            )
        }
    }
}

#Preview {
    ContentView()
}
