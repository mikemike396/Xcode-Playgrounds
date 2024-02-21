import SwiftUI
import AsyncAlgorithms

struct ContentView: View {
    @State var password = ""

    var body: some View {
        VStack {
            TextField("Password", text: $password)
        }
        .streamChanges(of: password) { stream in
            for await value in stream.debounce(for: .seconds(0.5)) {
                print(value)
            }
        }
    }
}
