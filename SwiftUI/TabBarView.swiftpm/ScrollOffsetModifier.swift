import SwiftUI

extension View {
    @ViewBuilder
    func scrollOffset(offset: @escaping (CGPoint) -> Void) -> some View {
        modifier(
            ScrollOffsetModifier(offset: offset)
        )
    }
}

struct ScrollOffsetModifier: ViewModifier {
    let offset: (CGPoint) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: PointPreferenceKey.self,
                        value: CGPoint(
                            x: -geometry.frame(in: .global).minX,
                            y: -geometry.frame(in: .global).minY
                        )
                    )
                }
            )
            .onPreferenceChange(PointPreferenceKey.self, perform: offset)
    }
}

private struct PointPreferenceKey: PreferenceKey {
    static let defaultValue = CGPoint.zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
