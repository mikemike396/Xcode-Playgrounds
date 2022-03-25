import Combine

struct ModelStruct {
    let labelText = CurrentValueSubject<String, Never>("")
    func fetchData(result: Bool) {
        labelText.send(result ? "Success" : "Failure")
    }
}

class ModelClass {
    @Published var test = ""
}

let modelStruct = ModelStruct()
modelStruct.labelText.sink { value in
    print(value)
}
let modelClass = ModelClass()
modelClass.$test.sink { value in
    print(value)
}

modelStruct.labelText.send("Testing using send")
modelStruct.labelText.value = "Testing updating value"
modelStruct.fetchData(result: true)
modelStruct.fetchData(result: false)

modelClass.test = "Test"
