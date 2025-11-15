//
//  FactoryModel.swift
//  Design Pattern
//
//  Created by Codex on 2025/11/15.
//

import Foundation

protocol WorkplaceProduct {
    var name: String { get }
    var emoji: String { get }
    func detail() -> String
}

struct ServiceRobot: WorkplaceProduct {
    let feature: String

    var name: String { "Service Robot" }
    var emoji: String { "🤖" }

    func detail() -> String {
        let featureText = feature.isEmpty ? "標準機能" : feature
        return "\(featureText)をこなす多目的ロボット。オフィス業務を自律的に処理します。"
    }
}

struct DeliveryDrone: WorkplaceProduct {
    let feature: String

    var name: String { "Delivery Drone" }
    var emoji: String { "🛰️" }

    func detail() -> String {
        let featureText = feature.isEmpty ? "標準機能" : feature
        return "\(featureText)に最適化された小型ドローン。ラストワンマイル配送を支援。"
    }
}

struct AIAssistant: WorkplaceProduct {
    let feature: String

    var name: String { "AI Assistant" }
    var emoji: String { "💡" }

    func detail() -> String {
        let featureText = feature.isEmpty ? "標準機能" : feature
        return "\(featureText)に特化したAIアシスタント。チームの意思決定を支えます。"
    }
}

protocol WorkplaceFactory {
    func create(feature: String) -> any WorkplaceProduct
}

struct ServiceRobotFactory: WorkplaceFactory {
    func create(feature: String) -> any WorkplaceProduct {
        ServiceRobot(feature: feature)
    }
}

struct DeliveryDroneFactory: WorkplaceFactory {
    func create(feature: String) -> any WorkplaceProduct {
        DeliveryDrone(feature: feature)
    }
}

struct AIAssistantFactory: WorkplaceFactory {
    func create(feature: String) -> any WorkplaceProduct {
        AIAssistant(feature: feature)
    }
}

enum FactoryProduct: String, CaseIterable, Identifiable {
    case robot
    case drone
    case assistant

    var id: String { rawValue }

    var label: String {
        switch self {
        case .robot: return "Service Robot"
        case .drone: return "Delivery Drone"
        case .assistant: return "AI Assistant"
        }
    }

    var emoji: String {
        switch self {
        case .robot: return "🤖"
        case .drone: return "🛰️"
        case .assistant: return "💡"
        }
    }

    var factory: any WorkplaceFactory {
        switch self {
        case .robot: return ServiceRobotFactory()
        case .drone: return DeliveryDroneFactory()
        case .assistant: return AIAssistantFactory()
        }
    }
}

struct FactoryState {
    var requestedFeature: String = ""
    var selectedProduct: FactoryProduct = .robot
    var currentProduct: any WorkplaceProduct
    var lastBuildStamp: String = ""

    init(
        requestedFeature: String = "",
        selectedProduct: FactoryProduct = .robot,
        currentProduct: (any WorkplaceProduct)? = nil,
        lastBuildStamp: String = ""
    ) {
        self.requestedFeature = requestedFeature
        self.selectedProduct = selectedProduct
        self.lastBuildStamp = lastBuildStamp
        if let currentProduct {
            self.currentProduct = currentProduct
        } else {
            self.currentProduct = selectedProduct.factory.create(feature: requestedFeature)
        }
    }
}

enum FactoryIntent {
    case updateFeature(String)
    case build(FactoryProduct)
}

enum FactoryReducer {
    static func reduce(state: inout FactoryState, intent: FactoryIntent) {
        switch intent {
        case .updateFeature(let text):
            state.requestedFeature = text
        case .build(let product):
            state.selectedProduct = product
            state.currentProduct = product.factory.create(feature: state.requestedFeature)
            state.lastBuildStamp = Date.now.formatted(date: .abbreviated, time: .shortened)
        }
    }
}
