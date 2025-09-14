import SwiftUI

struct ContentView: View {
    @State private var selected: Int?

    var body: some View {
        List(1...10, id: \.self) { item in
            Text(String(item))
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .foregroundStyle(.white)
                .tag(item)
                .listRowBackground(selected == item ? Color.gray.opacity(0.4) : Color.gray)
                .onTapGesture {
                    selected = item
                    // Action
                }
        }
        .task(id: selected) {
            try? await Task.sleep(for: .seconds(0.2))
            selected = nil
        }
    }
}
