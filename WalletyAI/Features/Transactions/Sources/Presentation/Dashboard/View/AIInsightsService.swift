import Foundation
import CoreML

public struct AIMessage: Identifiable, Equatable {
    public enum Role { case user, assistant }
    public let id: UUID = UUID()
    public let role: Role
    public let text: String
}

public protocol AIInsightsServicing {
    func send(prompt: String) async throws -> String
}

public final class AIInsightsService: AIInsightsServicing {
    private let queue = DispatchQueue(label: "ai.insights.service")
    // Placeholder for a Core ML model instance
    // private let model: MLModel

    public init() {
        // Load your Core ML model here when available
        // let config = MLModelConfiguration()
        // self.model = try! MyLocalLLM(configuration: config).model
    }

    public func send(prompt: String) async throws -> String {
        // Replace this stub with actual model inference.
        try await Task.sleep(nanoseconds: 350_000_000) // Simulate latency
        let lower = prompt.lowercased()
        if lower.contains("budget") {
            return "Based on your recent transactions, allocating 60% to essentials, 30% to discretionary, and 10% to savings could work well."
        } else if lower.contains("dining") || lower.contains("food") {
            return "Your dining spend trended down 12% last week. Consider setting a weekly cap to keep the momentum."
        } else if lower.contains("subscription") {
            return "You have 3 subscriptions renewing this month. Review them to avoid surprise charges."
        } else {
            return "Here’s an insight: Track categories with the largest variance month-over-month to find savings opportunities."
        }
    }
}
