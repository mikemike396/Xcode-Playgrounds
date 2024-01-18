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

    private var scrollView: some View {
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
            }
        }
        .padding(.top)
        .background(Color.blue)
    }
}
