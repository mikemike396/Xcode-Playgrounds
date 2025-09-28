import SwiftUI
import UniformTypeIdentifiers

struct ColorItem: Identifiable, Hashable {
    let id: UUID
    let name: String

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

extension UTType {
    static let colorItem = UTType(exportedAs: "com.example.coloritem")
}

struct ScrollViewOnDrag: View {
    @State private var colors: [ColorItem] = [
        ColorItem(name: "red"),
        ColorItem(name: "orange"),
        ColorItem(name: "yellow"),
        ColorItem(name: "green"),
        ColorItem(name: "blue"),
        ColorItem(name: "indigo"),
        ColorItem(name: "purple")
    ]
    @State private var draggedColor: ColorItem?

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(colors) { colorItem in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 50)
                        .overlay(
                            Text(colorItem.name.capitalized)
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                        .onDrag {
                            self.draggedColor = colorItem
                            return buildItemProviderForColorItem(colorItem)
                        }
                        .onDrop(
                            of: [UTType.colorItem],
                            delegate: CustomDropDelegate(
                                currentItem: colorItem,
                                colors: $colors,
                                draggedItem: $draggedColor
                            )
                        )
                }
            }
            .padding()
        }
    }

    private func buildItemProviderForColorItem(_ colorItem: ColorItem) -> NSItemProvider {
        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(
            forTypeIdentifier: UTType.colorItem.identifier,
            visibility: .all
        ) { completion in
            let data = colorItem.id.uuidString.data(using: .utf8) ?? Data()
            completion(data, nil)
            return nil
        }

        return itemProvider
    }
}

struct CustomDropDelegate: DropDelegate {
    let currentItem: ColorItem
    @Binding var colors: [ColorItem]
    @Binding var draggedItem: ColorItem?

    func canDrop(info: DropInfo) -> Bool {
        return draggedItem != nil && draggedItem?.id != currentItem.id
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func dropEntered(info: DropInfo) {
        guard let draggedColor = draggedItem,
              draggedColor.id != currentItem.id,
              let fromIndex = colors.firstIndex(where: { $0.id == draggedColor.id }),
              let toIndex = colors.firstIndex(where: { $0.id == currentItem.id })
        else { return }

        withAnimation {
            colors.move(
                fromOffsets: IndexSet(integer: fromIndex),
                toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex
            )
        }
    }

    func performDrop(info: DropInfo) -> Bool {
        guard draggedItem != nil else { return false }
        draggedItem = nil
        return true
    }
}

#Preview {
    ScrollViewOnDrag()
}
