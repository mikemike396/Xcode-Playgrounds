import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
//            let xdmDictionary = XDMBuilder()
//                .addWebPageDetails(pageViews: 1, name: "telus.1234", url: "telus.1234", customPageViews: 1)
//                .addWebInteraction(notificationImpressions: 1, notification: "Some Sick Notification")
//                .build()
            let xdmBillingparameters = XDMBillingParameters(notificationImpressions: 1, notification: "Some Sick Notification", pageViews: 1, name: "telus.1234", url: "telus.com", customPageViews: 1)
            let xdm = xdmBillingparameters.xdm
            if let json = try? JSONSerialization.data(withJSONObject: xdm, options: []) {
                print("\n\(json.prettyJson!)\n")
            }
        }
    }
}
