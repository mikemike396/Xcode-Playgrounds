// MARK: Protocol
protocol ProtocolAssociatedTypes {
    associatedtype DataType
    
    var items: [DataType] { get set }
    
    mutating func add(item: DataType)
    mutating func remove(item: DataType)
}

// MARK: Data Stores
struct StringTypeDataStore: ProtocolAssociatedTypes {
    var items = [String]()
    
    mutating func add(item: String) {
        items.append(item)
    }
    
    mutating func remove(item: String) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

struct IntTypeDataStore: ProtocolAssociatedTypes {
    var items = [Int]()
    
    mutating func add(item: Int) {
        items.append(item)
    }
    
    mutating func remove(item: Int) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}


// MARK: Usage
var stringStore = StringTypeDataStore()
stringStore.add(item: "Item 1")
stringStore.add(item: "Item 2")
print(stringStore)
stringStore.remove(item: "Item 2")
print(stringStore)

var intStore = IntTypeDataStore()
intStore.add(item: 1)
intStore.add(item: 2)
print(intStore)
intStore.remove(item: 2)
print(intStore)
