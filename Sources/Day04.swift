import Algorithms

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  let entities: [[Character]]

  init(data: String) {
    self.data = data
    self.entities = data.split(separator: "\n").map { Array($0) }
  }

  func part1() -> Any {
    let height = entities.count
    let width = entities[0].count
    var count = 0

    func checkPattern(word: String, startRow: Int, startCol: Int, rowDelta: Int, colDelta: Int)
      -> Bool
    {
      word.enumerated().allSatisfy { index, char in
        let row = startRow + (rowDelta * index)
        let col = startCol + (colDelta * index)

        guard row >= 0, row < height, col >= 0, col < width else { return false }
        return entities[row][col] == char
      }
    }

    // Check all positions and directions
    for (dx, dy) in [
      (0, 1),
      (0, -1),
      (1, 0),
      (-1, 0),
      (1, 1),
      (-1, -1),
      (1, -1),
      (-1, 1),
    ] {
      for row in 0..<height {
        for col in 0..<width {
          count +=
            checkPattern(word: "XMAS", startRow: row, startCol: col, rowDelta: dx, colDelta: dy)
            ? 1 : 0
        }
      }
    }
    return count
  }

  func part2() -> Any {
    let height = entities.count
    let width = entities[0].count
    var count = 0

    // Check each possible 3x3 grid position
    for row in 0...(height - 3) {
      for col in 0...(width - 3) {

        // Check if this 3x3 grid matches the pattern:
        // a.b
        // .A.
        // c.d

        // 'A' is a literal A. we care about the a-d corners too.

        if entities[row + 1][col + 1] == "A" {
          let a = entities[row][col]
          let b = entities[row][col + 2]
          let c = entities[row + 2][col]
          let d = entities[row + 2][col + 2]

          // Check all corners are either M or S
          guard Set([a, b, c, d]) == Set(["M", "S"]) else {
            continue
          }

          if a != d && b != c {
            count += 1
          }
        }
      }
    }

    return count
  }
}
