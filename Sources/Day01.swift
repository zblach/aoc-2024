import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [(a: Int, b: Int)] {
    data.split(separator: "\n").map { line in
      let numbers = line.split(separator: " ")
      return (a: Int(numbers[0])!, b: Int(numbers[1])!)
    }
  }

  var sortedPairs: (a: [Int], b: [Int]) {
    let (a, b) = entities.reduce(into: ([Int](), [Int]())) { result, pair in
      result.0.append(pair.a)
      result.1.append(pair.b)
    }
    return (a: a.sorted(), b: b.sorted())
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    zip(sortedPairs.a, sortedPairs.b)
      .map { abs($0 - $1) }
      .reduce(0, +)
  }

  func part2() -> Any {
    let bFrequencies = Dictionary(
      grouping: sortedPairs.b,
      by: { $0 }
    ).mapValues { $0.count }

    return sortedPairs.a
      .map { $0 * (bFrequencies[$0] ?? 0) }
      .reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
}
