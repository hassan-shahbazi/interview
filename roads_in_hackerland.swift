/*
*
* John lives in HackerLand, a country with N cities and M bidirectional roads.
* Each of the roads has a distinct length, and each length is a power of two
* (i.e., 2 raised to some exponent). It's possible for John to reach any city
* from any other city.

* Given a map of HackerLand, can you help John determine the sum of the
* minimum distances between each pair of cities?
* Print your answer in binary representation.
*
*/

/*
 * The solution below uses Dijkstra algorithm which is an efficient approach
 * for finding the shortest path between nodes in a graph. Howver, it doesn't
 * fit very well for this problem. With increasing number of nodes, the algorithms
 * might take hours to find the answer if it doesn't crash.
 * Thus, this is committed just for fun. There should be a better algorithm out there.
*/

import Foundation

func roads_in_hackerland(n: Int, roads: [[Int]]) -> String {
    let nodes = prepare_objects(n:n, roads)
    var sum = 0

    for i in 1...n {
        let o = nodes.first(where: { $0.name == i })
        if o == nil { continue }

        for j in i...n where i != j {
            let d = nodes.first(where: { $0.name == j })
            if d == nil { continue }

            nodes.forEach { $0.visited = false }

            let weight = weight_between(o: o!, d: d!, nodes, roads)
            print("found sum for \(i) to \(j): \(weight)")
            sum += weight
        }
    }

    return String(sum, radix: 2)
}

func prepare_objects(n: Int, _ roads: [[Int]]) -> [Node] {
    var nodes = [Node?](repeating: nil, count: n+1)

    roads.forEach { road in
        let source_index = road[0]
        var source = nodes[source_index]
        if source == nil {
            source = Node(name: source_index)
            nodes[source_index] = source
        }

        let dest_index = road[1]
        var dest = nodes[dest_index]
        if dest == nil {
            dest = Node(name: dest_index)
            nodes[dest_index] = dest
        }

        source!.connections.append(Connection(to: dest!, weight: road[2]))
        dest!.connections.append(Connection(to: source!, weight: road[2]))
    }

    print("objects are prepared")

    return nodes.compactMap { $0 }
}

func weight_between(o: Node, d: Node, _ nodes: [Node], _ roads: [[Int]]) -> Double {
    var frontier: [Path] = [] {
        didSet { frontier.sort { $0.cumulative_weight < $1.cumulative_weight } }
    }

    frontier.append(Path(to: o))
    if let o_d_conn = o.connections.first(where: { $0.to == d }) {
        frontier.append(Path(to: d, connection: o_d_conn))
    }

    while !frontier.isEmpty {
        let cheapest = frontier.removeFirst()
        guard !cheapest.node.visited else { continue }

        if cheapest.node == d {
            return cheapest.cumulative_weight
        }

        cheapest.node.visited = true
        cheapest.node.connections.filter({ !$0.to.visited }).forEach { conn in
            frontier.append(Path(to: conn.to, connection: conn, previous_path: cheapest))
        }
    }

    return 0
}

// `https://www.fivestars.blog/articles/dijkstra-algorithm-swift/`

final class Node: Hashable {
    let name: Int
    var visited: Bool = false
    var connections: [Connection] = []

    init(name: Int) {
        self.name = name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.name == rhs.name
    }
}
struct Connection {
    let to: Node
    let weight: Int
}
final class Path {
    let cumulative_weight: Double
    let node: Node
    let previous_path: Path?

    init(to node: Node, connection: Connection? = nil, previous_path: Path? = nil) {
        if let p_path = previous_path, let conn = connection {
            self.cumulative_weight = pow(2, Double(conn.weight)) + p_path.cumulative_weight
        } else if let conn = connection {
            self.cumulative_weight = pow(2, Double(conn.weight))
        } else {
            self.cumulative_weight = 0
        }

        self.node = node
        self.previous_path = previous_path
    }
}


// let test_suite_input = try! String(contentsOfFile: "roads_in_hackerland_input.txt")
// if test_suite_input.isEmpty {
//     fatalError("bad input")
// }
//
// let test_suite = test_suite_input.components(separatedBy: .newlines).reduce(into: []) { (result: inout [[Int]], t: String) in
//     let input = t.components(separatedBy: .whitespaces)
//     if input.count != 3 { return }
//
//     result.append(input.map({ Int($0)! }))
// }
// print(roads_in_hackerland(n: test_suite.count, roads: test_suite))

let roads = [[1,3,5], [4,5,0], [2,1,3], [3,2,1], [4,3,4], [4,2,2]]
print(roads_in_hackerland(n: 5, roads: roads))

let roads = [[1,3,5], [4,5,0], [2,1,3], [4,2,2]]
print(roads_in_hackerland(n: 5, roads: roads))
