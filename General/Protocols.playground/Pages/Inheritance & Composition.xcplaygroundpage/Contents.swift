import Foundation

enum PetType {
    case dog
    case horse
}
protocol Pet {
    var name: String { get set }
    var color: String { get set }
    var type: PetType { get set }
    
    func basicFunctionWith(variable: String)
}

extension Pet {
    func basicFunctionWith(variable: String) {
        // Default Implementation
    }
}

protocol Dog: Pet {
    var walkedToday: Bool { get }
}

protocol Horse: Pet {
    var roadInTheLastWeek: Bool { get }
}

struct MyDog: Dog {
    var walkedToday: Bool
    var name: String
    var color: String
    var type: PetType
}

struct MyHorse: Horse {
    var roadInTheLastWeek: Bool
    var name: String
    var color: String
    var type: PetType
}

var charlie = MyDog(walkedToday: false, name: "Charlie", color: "Black", type: .dog)
var horsey = MyHorse(roadInTheLastWeek: true, name: "Horsey", color: "White", type: .horse)

func print(value: Pet) {
    print(value)
    value.basicFunctionWith(variable: "blah")
    print(value.type)
}

print(value: charlie)

var myPets: [Pet] = []
myPets.append(charlie)
myPets.append(horsey)

print("My Pet Names: \(myPets.map { $0.name})")

