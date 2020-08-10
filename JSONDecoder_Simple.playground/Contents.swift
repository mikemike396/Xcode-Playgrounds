import UIKit

public struct SelectionLists: Codable
{
    public let selectionList : [String:value]
    
    public struct value: Codable {
        public let en: String
    }
}

let json2 = "{\"selectionList\":{\"1\":{\"en\":\"100 PSI\"},\"2\":{\"en\":\"150 PSI\"},\"3\":{\"en\":\"200 PSI\"},\"4\":{\"en\":\"300 PSI\"}}}"
    let jsonData = json2.data(using: .utf8)!
let lists = try? JSONDecoder().decode(SelectionLists.self, from: jsonData)

print(lists?.selectionList)
print(lists?.selectionList["1"]?.en)
