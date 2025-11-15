//
//  DecoratorModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

enum DecoratorLayer: String, CaseIterable, Identifiable {
    case border
    case glow
    case badge
    case shadow

    var id: String { rawValue }

    var label: String {
        switch self {
        case .border: return "リッチボーダー (+¥200)"
        case .glow: return "グロウエフェクト (+¥150)"
        case .badge: return "達成バッジ (+¥120)"
        case .shadow: return "ドロップシャドウ (+¥80)"
        }
    }

    var cost: Double {
        switch self {
        case .border: return 200
        case .glow: return 150
        case .badge: return 120
        case .shadow: return 80
        }
    }
}

struct DecoratorState {
    let basePrice: Double = 500
    var activeLayers: Set<DecoratorLayer> = []
    var note: String = "装飾の組み合わせを試してください。"

    var totalPrice: Double {
        activeLayers.reduce(basePrice) { $0 + $1.cost }
    }

    var summary: String {
        if activeLayers.isEmpty { return "ベースカードのみ" }
        let orderedLayers = DecoratorLayer.allCases.filter { activeLayers.contains($0) }
        let layers = orderedLayers.map { $0.rawValue.capitalized }.joined(separator: ", ")
        return "追加: \(layers)"
    }
}

enum DecoratorIntent {
    case toggle(DecoratorLayer, Bool)
    case reset
}

enum DecoratorReducer {
    static func reduce(state: inout DecoratorState, intent: DecoratorIntent) {
        switch intent {
        case let .toggle(layer, isOn):
            if isOn {
                state.activeLayers.insert(layer)
                state.note = "\(layer.label) を適用しました。"
            } else {
                state.activeLayers.remove(layer)
                state.note = "\(layer.label) を解除しました。"
            }
        case .reset:
            state.activeLayers.removeAll()
            state.note = "装飾をすべて解除しました。"
        }
    }
}
