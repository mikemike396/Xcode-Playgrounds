// MARK: Protocol
protocol ProtocolAssociatedTypes {
    associatedtype DataType
    var items: [DataType] { get set }
    
    func add(item: DataType)
    func remove(item: DataType)
}

// MARK: Data Stores
class StringTypeDataStore: ProtocolAssociatedTypes {
    typealias DataType = String
    var items = [String]()
    
    func add(item: String) {
        items.append(item)
    }
    
    func remove(item: String) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

class IntTypeDataStore: ProtocolAssociatedTypes {
    typealias DataType = Int
    var items = [Int]()
    
    func add(item: Int) {
        items.append(item)
    }
    
    func remove(item: Int) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

// MARK: Usage
var stringStore = StringTypeDataStore()
stringStore.add(item: "Item 1")
stringStore.add(item: "Item 2")
print(stringStore.items)
stringStore.remove(item: "Item 2")
print(stringStore.items)

var intStore = IntTypeDataStore()
intStore.add(item: 1)
intStore.add(item: 2)
print(intStore.items)
intStore.remove(item: 2)
print(intStore.items)
