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

    func checkPattern(word: String, cell: (r: Int, c: Int), delta: (x: Int, y: Int)) -> Bool {
      word.enumerated().allSatisfy { index, char in
        let (row, col) = (cell.r + (delta.x * index), cell.c + (delta.y * index))

        guard (0..<height).contains(row), (0..<width).contains(col) else { return false }

        return entities[row][col] == char
      }
    }

    let directions = [
      (0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (-1, -1), (1, -1), (-1, 1),
    ]

    return product(0..<height, 0..<width).reduce(0) { sum, pos in
      sum + directions.count { delta in checkPattern(word: "XMAS", cell: pos, delta: delta) }
    }

  }

  func part2() -> Any {
    let height = entities.count
    let width = entities[0].count

    let ms: Set<Character> = ["M", "S"]

    // Check each possible 3x3 grid position
    return product(0..<(height - 2), 0..<(width - 2)).count { row, col in
      // Check if this 3x3 grid matches the pattern:
      // a.b
      // .A.
      // c.d

      // 'A' is a literal A. a-d are the corners that must be either M or S.
      guard entities[row + 1][col + 1] == "A" else { return false }

      let a = entities[row][col]
      let b = entities[row][col + 2]
      let c = entities[row + 2][col]
      let d = entities[row + 2][col + 2]

      // Check all corners are either M or S.
      guard [a, b, c, d].allSatisfy(ms.contains) else { return false }

      // Check that diagonals differ. MAM and SAS aren't allowed.
      guard a != d, b != c else { return false }

      return true
    }
  }
}
