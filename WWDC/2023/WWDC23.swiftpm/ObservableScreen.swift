import Observation
import SwiftUI

// MARK: - Old Way
class OldNestedViewModel: ObservableObject {
    @Published var list: [String] = []
}

class OldObservable: ObservableObject {
    @Published var list: [String] = []
    @Published var nestedViewModel = OldNestedViewModel()
}


// MARK: - New Way
@Observable class NestedViewModel {
    var list: [String] = []
}

@Observable class NewObservable {
    var list: [String] = []
    var nestedViewModel = NestedViewModel()
}

struct ObservableScreen: View {
    @StateObject var oldObservable = OldObservable()
    @State var newObservable = NewObservable()

    var body: some View {
        VStack(spacing: 5) {
            ForEach($newObservable.nestedViewModel.list, id: \.self) { value in
                Text(value.wrappedValue)
            }

            Button {
                newObservable.nestedViewModel.list.append("New")
            } label: {
                Text("Add To List New Way")
            }

            ForEach($oldObservable.nestedViewModel.list, id: \.self) { value in
                Text(value.wrappedValue)
            }

            Button {
                oldObservable.nestedViewModel.list.append("Old")
            } label: {
                Text("Add To List Old Way")
            }
        }

        .padding()
    }
}

#Preview {
    ObservableScreen()
}
