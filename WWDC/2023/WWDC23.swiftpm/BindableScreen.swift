import Observation
import SwiftUI

@Observable class Model {
    var name: String = ""
}

struct BindableScreen: View {
    @Bindable var model: Model

    var body: some View {
        TextField("Name", text: $model.name)
    }
}

#Preview {
    BindableScreen(model: Model())
}
