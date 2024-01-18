import SwiftUI

struct ContentView: View {
    @State var sheetPresented = false
    @State var detent = PresentationDetent.medium

    var body: some View {
        VStack {
            Button("Press Me") {
                sheetPresented.toggle()
            }
        }
        .sheet(isPresented: $sheetPresented) {
            scrollView
                .presentationDetents([.medium, .large], selection: $detent)
        }
    }

    @ViewBuilder private var scrollView: some View {
        if #available(iOS 17.0, *) {
            VStack {
                Button("Collapse") {
                    detent = .medium
                }
                ScrollView {
                    VStack {
                        ForEach(0..<100) { index in
                            Text(String(index))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .background(Color.blue)
                }
            }
            // FIX for ScrollView collapsing before sheet animation finishes
            //.scrollClipDisabled(true)
            .padding(.top)
        } else {
            // Fallback on earlier versions
        }
    }
}
