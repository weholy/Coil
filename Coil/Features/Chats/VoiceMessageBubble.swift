import SwiftUI

struct VoiceMessageBubble: View {
    let isMine: Bool
    let duration: Int
    @State private var isPlaying = false
    @State private var showsTranscript = false

    private var tint: Color { isMine ? Palette.bubbleTextMine : Palette.bubbleTextOther }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(tint)
                        .frame(width: 30, height: 30)
                        .background(tint.opacity(0.16), in: Circle())
                }
                .buttonStyle(.plain)

                waveform

                Text(durationText)
                    .font(Typography.footnote)
                    .foregroundStyle(tint.opacity(0.8))
            }

            Button {
                showsTranscript.toggle()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "waveform")
                        .font(.system(size: 11))
                    Text("Расшифровать")
                        .font(Typography.footnote)
                }
                .foregroundStyle(tint.opacity(0.8))
            }
            .buttonStyle(.plain)

            if showsTranscript {
                Text("Расшифровка появится здесь")
                    .font(Typography.footnote)
                    .foregroundStyle(tint.opacity(0.7))
            }
        }
        .frame(width: 200, alignment: .leading)
    }

    private var waveform: some View {
        HStack(spacing: 2.5) {
            ForEach(0..<24, id: \.self) { index in
                Capsule()
                    .fill(tint.opacity(0.55))
                    .frame(width: 2, height: barHeight(index))
            }
        }
        .frame(height: 24)
    }

    private func barHeight(_ index: Int) -> CGFloat {
        let pattern: [CGFloat] = [6, 12, 18, 10, 22, 14, 8, 16, 24, 12, 6, 18, 10, 20, 8, 14, 22, 6, 16, 10, 18, 8, 12, 6]
        return pattern[index % pattern.count]
    }

    private var durationText: String {
        String(format: "%d:%02d", duration / 60, duration % 60)
    }
}
