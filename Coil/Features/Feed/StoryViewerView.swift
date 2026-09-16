import SwiftUI

struct StoryViewerView: View {
    let group: StoryGroup
    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex = 0
    @State private var progress: CGFloat = 0
    @State private var replyText = ""
    @State private var isLiked = false

    private let segmentDuration: TimeInterval = 5
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    private var author: User {
        group.authors.count > 1 ? group.authors[currentIndex % group.authors.count] : group.authors[0]
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: author.tint.colors, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            tapZones

            VStack(spacing: 0) {
                progressBars
                    .padding(.horizontal, 8)
                    .padding(.top, 8)

                header
                    .padding(.horizontal, 14)
                    .padding(.top, 10)

                Spacer()

                bottomBar
                    .padding(.horizontal, 14)
                    .padding(.bottom, 10)
            }
        }
        .onReceive(timer) { _ in
            advance(by: 0.05 / segmentDuration)
        }
        .statusBarHidden()
    }

    private var progressBars: some View {
        HStack(spacing: 4) {
            ForEach(0..<group.segmentCount, id: \.self) { index in
                GeometryReader { proxy in
                    Capsule()
                        .fill(.white.opacity(0.3))
                        .overlay(alignment: .leading) {
                            Capsule()
                                .fill(.white)
                                .frame(width: proxy.size.width * segmentProgress(for: index))
                        }
                }
                .frame(height: 2.5)
            }
        }
    }

    private func segmentProgress(for index: Int) -> CGFloat {
        if index < currentIndex { return 1 }
        if index == currentIndex { return progress }
        return 0
    }

    private var header: some View {
        HStack(spacing: 10) {
            AvatarView(user: author, size: 34)

            VStack(alignment: .leading, spacing: 0) {
                Text(author.displayName)
                    .font(Typography.subheadline)
                    .foregroundStyle(.white)
                Text("только что")
                    .font(Typography.footnote)
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()

            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
            }
            .buttonStyle(.plain)
            .glassCircle()
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 10) {
            TextField("", text: $replyText, prompt: Text("Ответить").foregroundStyle(.white.opacity(0.7)))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .frame(height: 42)
                .glassCapsule()

            Button {
                isLiked.toggle()
            } label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundStyle(isLiked ? Palette.destructive : .white)
                    .frame(width: 42, height: 42)
            }
            .buttonStyle(.plain)
            .glassCircle()

            Button {
            } label: {
                Image(systemName: "paperplane")
                    .foregroundStyle(.white)
                    .frame(width: 42, height: 42)
            }
            .buttonStyle(.plain)
            .glassCircle()
        }
    }

    private var tapZones: some View {
        HStack(spacing: 0) {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { goToPrevious() }
                .frame(maxWidth: .infinity)

            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { goToNext() }
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func advance(by delta: CGFloat) {
        progress += delta
        if progress >= 1 {
            goToNext()
        }
    }

    private func goToNext() {
        if currentIndex < group.segmentCount - 1 {
            currentIndex += 1
            progress = 0
        } else {
            dismiss()
        }
    }

    private func goToPrevious() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
        progress = 0
    }
}
