import SwiftUI

@main
struct MyApp: App {
    @ObservedObject var model = Model()

    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
