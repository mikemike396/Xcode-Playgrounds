import SwiftUI
import PlaygroundSupport

protocol LabelDataModel: Hashable {}

struct LabelType1: LabelDataModel {
    var testString = "Label Type 1 Test String"
}

struct LabelType2: LabelDataModel {
    var testString = "Label Type 2 Test String"
}

struct LabelModel<T: LabelDataModel>: Hashable {
    var displayString: String
    var color: Color
    var model: T?
}

protocol LabelItems: ObservableObject {
    associatedtype T: LabelDataModel
    var items: [LabelModel<T>] { get set }
    var selectedValue: String { get set }

    func fetchItems()
}

class LabelType1ViewModel: LabelItems {
    @Published var items: [LabelModel<LabelType1>] = []
    @Published var selectedValue = ""
    func fetchItems() {
        items = [LabelModel(displayString: "Type 1 Display 1", color: Color.red, model: LabelType1()),
                 LabelModel(displayString: "Type 1 Display 2", color: Color.red, model: LabelType1())]
        selectedValue = items.first?.model?.testString ?? ""
    }
}

class LabelType2ViewModel: LabelItems {
    @Published var items: [LabelModel<LabelType2>] = []
    @Published var selectedValue = ""
    func fetchItems(){
        items = [LabelModel(displayString: "Type 2 Display 1", color: Color.blue, model: LabelType2()),
                 LabelModel(displayString: "Type 2 Display 2", color: Color.blue, model: LabelType2())]
        selectedValue = items.first?.model?.testString ?? ""
    }
}

struct ContentView<ViewModel: LabelItems>: View  {
    @ObservedObject var viewModel:ViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.items, id: \.self) { item in
                Text(item.displayString)
                    .foregroundColor(item.color)
                Text(viewModel.selectedValue)
            }
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}

//let view = ContentView(viewModel: LabelType1ViewModel())
let view = ContentView(viewModel: LabelType2ViewModel())
let hostingVC = UIHostingController(rootView: view)
PlaygroundPage.current.liveView = hostingVC
