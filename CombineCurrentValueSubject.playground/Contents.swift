import Combine

struct Model {
    let labelText = CurrentValueSubject<String, Never>("")
    func fetchData(result: Bool) {
        labelText.send(result ? "Success" : "Failure")
    }
}

let model = Model()
model.labelText.sink { value in
    print(value)
}

model.labelText.send("Testing using send")
model.labelText.value = "Testing updating value"
model.fetchData(result: true)
model.fetchData(result: false)
