import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ObservableScreen()
                    .tabItem {
                        Image(systemName: "arrow.clockwise")
                        Text("Observable")
                    }

                BindableScreen(model: Model())
                    .tabItem {
                        Image(systemName: "app.connected.to.app.below.fill")
                        Text("Bindable")
                    }
            }
        }
    }
}
