import Combine
import SwiftUI

@MainActor
struct ContentView: View {
    let model = Model()

    var body: some View {
        VStack {
            Button("Send") {
                model.increment()
            }
        }
        .onAppear {
            model.startObserver()
        }
    }
}

@MainActor
class Model: ObservableObject {
    @Published var counter = 0
    var cancellables = Set<AnyCancellable>()

    func increment() {
        counter += 1
    }

    func startObserver() {
        let values = $counter
            //.buffer(size: .max, prefetch: .byRequest, whenFull: .dropOldest)
            .values

        // AsyncStream
        Task { [weak self] in
            var lastReceived = 0

            for await value in values {
                guard let self else { return }

                print("Async: \(value)")
                try await Task.sleep(for: .milliseconds(500))
            }
        }

        // Combine
        $counter
            .sink { [weak self] value in
                guard let self else { return }

                Task {
                    print("Combine: \(value)")
                    try await Task.sleep(for: .milliseconds(500))
                }
            }
            .store(in: &cancellables)
    }
}
