import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                DownloadFileScreen()
                    .tabItem {
                        Image(systemName: "arrow.down.circle")
                        Text("Download File")
                    }
            }
        }
    }
}
