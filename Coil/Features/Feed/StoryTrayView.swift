import SwiftUI

struct StoryRingView: View {
    let group: StoryGroup

    var body: some View {
        Group {
            if group.authors.count > 1 {
                stackedAvatars
            } else {
                ringedAvatar(group.authors[0], size: Metrics.storyRingSize - 10)
            }
        }
        .frame(width: Metrics.storyRingSize, height: Metrics.storyRingSize)
    }

    private func ringedAvatar(_ user: User, size: CGFloat) -> some View {
        AvatarView(user: user, size: size)
            .padding(4)
            .background {
                Circle()
                    .strokeBorder(ringStyle, lineWidth: 2.5)
            }
    }

    private var ringStyle: AnyShapeStyle {
        group.isSeen
            ? AnyShapeStyle(Palette.storyRingSeen)
            : AnyShapeStyle(AngularGradient(colors: Palette.storyRingUnseen, center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
    }

    private var stackedAvatars: some View {
        ZStack {
            ringedAvatar(group.authors[1], size: Metrics.storyRingSize * 0.62)
                .offset(x: 11, y: 11)
            ringedAvatar(group.authors[0], size: Metrics.storyRingSize * 0.62)
                .offset(x: -11, y: -11)
        }
    }
}

struct StoryTrayView: View {
    let stories: [StoryGroup]
    let me: User
    var onAddStory: () -> Void = {}
    var onSelect: (StoryGroup) -> Void = { _ in }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                Button(action: onAddStory) {
                    VStack(spacing: 6) {
                        ZStack(alignment: .bottomTrailing) {
                            AvatarView(user: me, size: Metrics.storyRingSize - 10)
                                .padding(4)
                                .overlay { Circle().stroke(Palette.hairline, lineWidth: 1.5) }

                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.white, Palette.accent)
                        }
                        Text("Вы")
                            .font(Typography.footnote)
                            .foregroundStyle(Palette.textSecondary)
                    }
                }
                .buttonStyle(.plain)

                ForEach(stories) { group in
                    Button {
                        onSelect(group)
                    } label: {
                        VStack(spacing: 6) {
                            StoryRingView(group: group)
                            Text(group.authors[0].displayName.components(separatedBy: " ").first ?? "")
                                .font(Typography.footnote)
                                .foregroundStyle(Palette.textSecondary)
                                .lineLimit(1)
                                .frame(width: Metrics.storyRingSize)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, Metrics.screenPadding)
        }
    }
}
