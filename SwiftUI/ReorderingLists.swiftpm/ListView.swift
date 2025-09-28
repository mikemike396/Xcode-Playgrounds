import SwiftUI

struct SectionItem: Identifiable {
    let id = UUID()
    var name: String
    var children: [SectionItem] = []
}

struct ListView: View {
    @State private var sections: [SectionItem] = [
        SectionItem(name: "Parent 1", children: [
            SectionItem(name: "Child 1.1"),
            SectionItem(name: "Child 1.2")
        ]),
        SectionItem(name: "Parent 2", children: [
            SectionItem(name: "Child 2.1")
        ]),
        SectionItem(name: "Parent 3", children: [
        ])
    ]

    var body: some View {
        List {
            ForEach($sections) { $parent in
                DisclosureGroup(parent.name) {
                    ForEach($parent.children) { $child in
                        Text(child.name)
                    }
                    .onMove { indices, newOffset in
                        parent.children.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
            }
            .onMove { indices, newOffset in
                sections.move(fromOffsets: indices, toOffset: newOffset)
            }
        }
    }
}
