import Foundation

struct Client {
    var fetch: () async throws -> [String]
    var add: ((String) async throws -> Void)?
}

extension Client {
    static func setup() -> Client {
        let session = URLSession.shared
        return Client(
            fetch: {
                [
                    "Test",
                    "Test2"
                ]
            },

            add: { item in
                print("Added \(item)")
            }
        )
    }
}

class ViewModel {
    let client: Client

    init(client: Client = Client.setup()) {
        self.client = client
        Task {
            let items = try? await client.fetch()
            print("Fetch: \(items)")

            try? await client.add?("Add 123")
        }
    }
}

class TestExampleClass {
    init() {
        let mockClient = Client(fetch: { ["Mock1", "Mock2"] }, add: { item in print("Mock Add \(item)") })
        
        let viewModel = ViewModel(client: mockClient)
    }
}

let testExample = TestExampleClass()
let concreteViewModel = ViewModel()
