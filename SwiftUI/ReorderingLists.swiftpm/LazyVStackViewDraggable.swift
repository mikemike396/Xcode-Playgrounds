import SwiftUI

struct LazyVStackViewDraggable: View {
    @State private var colors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .indigo, .purple
    ]
    @State var draggingColor: Color?
    @State var draggingSize: CGSize = .zero

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                        .frame(height: 50)
                        .draggable(color) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient.opacity(0.7))
                                .frame(width: draggingSize.width, height: draggingSize.height)
                                .onAppear {
                                    draggingColor = color
                                }
                        }
                        .onGeometryChange(for: CGSize.self) { geometry in
                            geometry.size
                        } action: { value in
                            print("value: \(value)")
                            draggingSize = value
                        }
                        .dropDestination(for: Color.self) { items, location in
                            draggingColor = nil
                            return false
                        } isTargeted: { status in
                            if let draggingColor, status, draggingColor != color {
                                if let sourceIndex  = colors.firstIndex(of: draggingColor),
                                   let destinationIndex = colors.firstIndex(of: color) {
                                    withAnimation(.bouncy) {
                                        let sourceItem = colors.remove(at: sourceIndex)
                                        colors.insert(sourceItem, at: destinationIndex)
                                    }
                                }
                            }
                        }

                }
            }
        }
    }
}

#Preview {
    LazyVStackViewDraggable()
}
