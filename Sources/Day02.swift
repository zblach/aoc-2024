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
      isOrdered($0) && gapWidth($0, width: 3)
    }
  }

  func isOrdered(_ l: [Int]) -> Bool {
    guard !l.isEmpty else { return true }
    return zip(l, l.dropFirst()).allSatisfy(<)
      || zip(l, l.dropFirst()).allSatisfy(>)
  }

  func gapWidth(_ l: [Int], width: Int) -> Bool {
    l.adjacentPairs().allSatisfy { (1...width).contains(abs($0 - $1)) }
  }

  func part2() -> Any {
    entities.filter { arr in
      arr.indices.contains { i in
        var subset = arr
        subset.remove(at: i)
        return isOrdered(subset) && gapWidth(subset, width: 3)
      }
    }.count
  }
}
