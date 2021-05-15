/*
* 
* Problem:
*   find all values associated with key K in a json string. The key can be 
*   appeared in different levels, but all values have the same type.
*
*/

import Foundation

func find_values(_ json: String, key: String) -> [Any] {
    guard let dictionary = json.toDictionary else { return [] }

    return dictionary.find_values(for: key)
}


extension String {
    var toDictionary: [String:Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try JSONSerialization.jsonObject(
                                                    with: data, 
                                                    options: .mutableContainers
                                                ) as? [String:Any]
        } catch {
            return nil
        }
    }
}

extension Dictionary where Key==String {
    func find_values(for key: String) -> [Any] {
        var keys: [Any] = []

        if let value = self[key] {
            keys.append(value)
        }
        self.values.compactMap({ $0 as? [String:Any] }).forEach({
            keys.append(contentsOf: $0.find_values(for: key))
        })

        return keys
    }
}


let sample_json = """
{
    "parent": {
        "child_1": "v",
        "child_2": {
            "key": "V1",
            "child_22": "v"
        },
        "child_3": {
            "child_31": {
                "child_2": {
                    "key": "v2"
                }
            }
        },
        "key": "v3",
        "child_4": "key"
    }
}
"""

print(find_values(sample_json, key: "key"))
print(find_values(sample_json, key: "child_1"))
print(find_values(sample_json, key: "child_2"))
