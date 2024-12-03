import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    return data.matches(of: /mul\((\d+),(\d+)\)/).reduce(0) { acc, m in
      acc + (Int(m.1)! * Int(m.2)!)
    }
  }

  func part2() -> Any {
    let doFlag: Regex<Substring> = /do\(\)/
    let dontFlag: Regex<Substring> = /don't\(\)/
    let mulOp: Regex<(Substring, Substring, Substring)> = /mul\((\d+),(\d+)\)/

    return data.matches(
      of: Regex {
        ChoiceOf {
          doFlag
          dontFlag
          mulOp
        }
      }
    ).reduce((enabled: true, acc: 0)) { result, match in
      switch match.0 {
      case "do()":
        return (true, result.acc)
      case "don't()":
        return (false, result.acc)
      case let mul:
        if let (_, n1, n2) = try? mulOp.wholeMatch(in: mul)?.output {
          let a = Int(n1)!
          let b = Int(n2)!
          return (result.enabled, result.enabled ? result.acc + (a * b) : result.acc)
        }
        return result
      }
    }.acc
  }
}
