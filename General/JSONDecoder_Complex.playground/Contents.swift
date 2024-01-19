import UIKit

let jsonString = """
{
  "1": {
    "en": "100 PSI"
  },
  "2": {
    "en": "150 PSI"
  },
  "3": {
    "en": "200 PSI"
  }
}
"""

struct Outer: Codable {
    let en: String
    
    let inner: [String:String]

    enum CodingKeys: CodingKey {
      case en
    }

    init(from decoder: Decoder) throws {

      let container = try decoder.container(keyedBy: CodingKeys.self)
      en = ""
      inner = [container.codingPath.first!.stringValue:try container.decode(String.self, forKey: CodingKeys.en)]
    }
}

struct DecodedArray: Decodable {

    var array: [Outer]
    
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [Outer]()

        // 2
        // Loop through each key (student ID) in container
        for key in container.allKeys {

            // Decode Student using key & keep decoded Student object in tempArray
            let decodedObject = try container.decode(Outer.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        // 3
        // Finish decoding all Student objects. Thus assign tempArray to array.
        array = tempArray
    }
}

let jsonData = Data(jsonString.utf8)

// Ask JSONDecoder to decode the JSON data as DecodedArray
let decodedResult = try! JSONDecoder().decode(DecodedArray.self, from: jsonData)

dump(decodedResult.array)
