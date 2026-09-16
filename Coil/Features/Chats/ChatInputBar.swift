import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    var onAttach: () -> Void = {}
    var onSend: () -> Void = {}
    var onRecordVoice: () -> Void = {}

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onAttach) {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)
            .glassCircle(interactive: true)

            TextField("Сообщение", text: $text, axis: .vertical)
                .font(Typography.body)
                .lineLimit(1...6)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .glassCapsule()

            Button(action: canSend ? onSend : onRecordVoice) {
                Image(systemName: canSend ? "arrow.up" : "mic.fill")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)
            .glassCircle(interactive: true)
        }
        .padding(.horizontal, Metrics.screenPadding)
        .padding(.vertical, 8)
    }
}
