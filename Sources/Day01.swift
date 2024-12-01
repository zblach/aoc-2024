import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [(Int, Int)] {
    data.split(separator: "\n").map {
      let nums = $0.split(separator: " ")
      return (Int(nums[0])!, Int(nums[1])!)
    }
  }

  var sortedData: ([Int], [Int]) {
    var A = [Int]()
    var B = [Int]()

    entities.forEach {
      A.append($0.0)
      B.append($0.1)
    }

    A.sort()
    B.sort()

    return (A, B)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    return zip(sortedData.0, sortedData.1).map { abs($0 - $1) }.reduce(0, +)

  }

  func part2() -> Any {
    var bFreq = [Int: Int]()
    sortedData.1.forEach { bFreq[$0, default: 0] += 1 }

    return sortedData.0.map { $0 * bFreq[$0, default: 0] }.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
}
