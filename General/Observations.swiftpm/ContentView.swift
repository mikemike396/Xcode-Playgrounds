import SwiftUI

struct ContentView: View {
    @State var model = Model()

    var body: some View {
        VStack {
            Button("Increment") {
                model.count += 1
            }
            Text(String(model.count))
        }
    }
}

@Observable
class Model {
    var count = 0

    init() {
        setupObservations()
    }

    private func setupObservations() {
        let countValues = Observations {
            self.count
        }
        Task { @MainActor [weak self] in
            for await count in countValues {
                guard let self else { return }
                print("Count changed to \(count)")
            }
        }
    }
}
