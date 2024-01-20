import SwiftUI

/// This demonstrates the use of `Task(id:)`
/// If we change the UUID value it automatically cancels the previous task
struct ContentView: View {
    @State var code = 0
    @State var uuid: UUID?
    
    var body: some View {
        VStack {
            qrCodeImage
            Button {
                uuid = UUID()
                code += 1
            } label: {
                Image(systemName: "arrow.clockwise.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
        }
        .task(id: uuid) {
            do {
                try await Task.sleep(for: .seconds(2))
                code += 1
            } catch {}
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                uuid = UUID()
            }
        }
    }
    
    var qrCodeImage: some View {
        Text("\(code)")
            .font(.title)
            .fontWeight(.bold)
    }
}
