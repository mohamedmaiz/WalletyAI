import Foundation
import Combine

final class AIInsightsViewModel: ObservableObject {
    @Published private(set) var messages: [AIMessage] = []
    @Published var isSending: Bool = false
    @Published var inputText: String = ""
    let classifier = TransactionClassifierService()
    
    private let service: AIInsightsServicing

    init(service: AIInsightsServicing = AIInsightsService()) {
        self.service = service
        // Seed with a greeting
        messages.append(AIMessage(role: .assistant, text: "Hi! Ask me about your spending, budgets, or ways to save."))
    }

    @MainActor
    func sendCurrentInput() async {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !isSending else { return }
        inputText = ""
        await send(text: text)
    }

    @MainActor
    func send(text: String) async {
        isSending = true
        let userMessage = AIMessage(role: .user, text: text)
        messages.append(userMessage)
        do {
            let aiMessage = try await classifier.classify(text)
            messages
                .append(
                    AIMessage(
                        role: .assistant,
                        text: aiMessage.category
                    )
                )
        } catch {
            messages.append(AIMessage(role: .assistant, text: "Sorry, I couldn't process that right now."))
        }
        isSending = false
    }
}
