import Foundation
import SwiftUI
import PlaygroundSupport

struct ContentView: View {

    var attributedString: AttributedString {
        
        var text = AttributedString("This is some sweet text about some book.")

        if let range = text.range(of: "sweet") {
            text[range].backgroundColor = .yellow
        }

        if let range = text.range(of: "This") {
            text[range].backgroundColor = .blue
        }
        return text
    }

    var body: some View {
        VStack {
            Text(attributedString)
        }
        .frame(width: 200, height: 200)
    }
}


let view = ContentView()
let hostingVC = UIHostingController(rootView: view)
PlaygroundPage.current.liveView = hostingVC
