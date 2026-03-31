import SwiftUI

struct AIInsightsView: View {
    @StateObject var vm: AIInsightsViewModel = AIInsightsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundStyle(Color.electricBlue)
                Text("AI Insights")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.background)

            // Messages list
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(vm.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .background(Color.background)
                .onChange(of: vm.messages) { _, _ in
                    if let last = vm.messages.last?.id {
                        withAnimation(.easeOut(duration: 0.2)) {
                            proxy.scrollTo(last, anchor: .bottom)
                        }
                    }
                }
            }

            // Input
            ChatInputBar(text: $vm.inputText, isSending: vm.isSending) {
                Task { await vm.sendCurrentInput() }
            }
            .padding(.bottom, 8)
            .background(Color.background)
        }
        .background(Color.background.ignoresSafeArea())
    }
}

private struct ChatBubble: View {
    let message: AIMessage

    var body: some View {
        HStack(alignment: .bottom) {
            if message.role == .assistant { Spacer(minLength: 0) }
            VStack(alignment: .leading, spacing: 6) {
                Text(message.text)
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(message.role == .user ? Color.electricBlue.opacity(0.25) : Color.darkBlueViolet.opacity(0.25))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.blueGray.opacity(0.4))
            )
            if message.role == .user { Spacer(minLength: 0) }
        }
    }
}

private struct ChatInputBar: View {
    @Binding var text: String
    var isSending: Bool
    var onSend: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            TextField("Ask about spending, budgets…", text: $text, axis: .vertical)
                .textFieldStyle(.plain)
                .foregroundStyle(.white)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.blueGray.opacity(0.4))
                )

            Button(action: { if !isSending { onSend() } }) {
                Image(systemName: isSending ? "hourglass" : "paperplane.fill")
                    .foregroundStyle(Color.electricBlue)
                    .padding(10)
                    .background(
                        Circle().fill(Color.electricBlue.opacity(0.12))
                    )
            }
            .buttonStyle(.plain)
            .disabled(isSending)
        }
        .padding(.horizontal, 12)
        .padding(.top, 8)
    }
}

// New chat style view for bottom sheet presentation
struct AIInsightsChatView: View {
    @StateObject var vm: AIInsightsViewModel = AIInsightsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Messages list
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(vm.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .background(Color.background)
                .onChange(of: vm.messages) { _, _ in
                    if let last = vm.messages.last?.id {
                        withAnimation(.easeOut(duration: 0.2)) {
                            proxy.scrollTo(last, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()
                .background(Color.blueGray)

            // Toolbar-like input bar
            HStack(spacing: 8) {
                TextField("Ask about spending, budgets…", text: $vm.inputText, axis: .vertical)
                    .textFieldStyle(.plain)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.white.opacity(0.06))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.blueGray.opacity(0.4))
                    )

                Button(action: {
                    if !vm.isSending {
                        Task { await vm.sendCurrentInput() }
                    }
                }) {
                    Image(systemName: vm.isSending ? "hourglass" : "paperplane.fill")
                        .foregroundStyle(Color.electricBlue)
                        .padding(10)
                        .background(
                            Circle().fill(Color.electricBlue.opacity(0.12))
                        )
                }
                .buttonStyle(.plain)
                .disabled(vm.isSending)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.background)
            .toolbarBackground(Color.background, for: .bottomBar)
        }
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    AIInsightsView()
        .background(Color.background)

    AIInsightsChatView()
        .background(Color.background)
}
