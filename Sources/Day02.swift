import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map { line in
      line.split(separator: " ").map { Int($0)! }
    }
  }

  func part1() -> Any {
    entities.count {
      okay($0)
    }
  }

  func okay(_ l: [Int]) -> Bool {
    let ap = l.adjacentPairs()
    return (ap.allSatisfy(<) || ap.allSatisfy(>)) && ap.allSatisfy { abs($0 - $1) <= 3 }
  }

  func part2() -> Any {
    entities.filter { arr in
      arr.indices.contains { i in
        var subset = arr
        subset.remove(at: i)
        return okay(subset)
      }
    }.count
  }
}
