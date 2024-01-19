import SwiftUI

struct ContentView<Source: ListSource>: View {
    @ObservedObject var model: Source

    var body: some View {
        VStack {
            List(model.items, id: \.self) { item in
                Text(item)
            }

            Button("Add") {
                model.items.append("\(model.items.count)")
            }
        }
    }
}
