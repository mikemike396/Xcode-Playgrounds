import Combine

protocol ListSource: ObservableObject {
    var items: [String] { get set }
}

class Model: ListSource {
    @Published var items: [String] = ["Test123"]
    var name: String?
    var city: String?
}

class AnotherModel: ListSource {
    @Published var items: [String] = ["Test345"]
    var name: String?
    var city: String?
}
