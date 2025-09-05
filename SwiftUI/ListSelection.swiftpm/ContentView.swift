import SwiftUI

struct ContentView: View {
    @State private var selected: Int?

    var body: some View {
        List(1...10, id: \.self, selection: $selected) { item in
            Text(String(item))
                .foregroundStyle(.white)
                .tag(item)
                .listRowBackground(selected == item ? Color.gray.opacity(0.4) : Color.gray)
                .onTapGesture {
                    // Action
                }
        }
        .task(id: selected) {
            try? await Task.sleep(for: .seconds(0.2))
            selected = nil
        }
    }
}
