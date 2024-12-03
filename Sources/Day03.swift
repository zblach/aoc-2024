import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  var data: String

  func part1() -> Any {
    let mulOp: Regex<(Substring, Substring, Substring)> = /mul\((\d+),(\d+)\)/
    return data.matches(of: mulOp).reduce(0) { acc, m in
      acc + (Int(m.1)! * Int(m.2)!)
    }
  }

  func part2() -> Any {
    let doStr = "do()"
    let dontStr = "don't()"
    let mulOp: Regex<(Substring, Substring, Substring)> = /mul\((\d+),(\d+)\)/

    let pattern = Regex {
      ChoiceOf {
        Regex { doStr }
        Regex { dontStr }
        mulOp
      }
    }

    return data.matches(of: pattern).reduce((enabled: true, acc: 0)) { result, match in
      switch match.0 {
      case doStr:  // do
        return (true, result.acc)
      case dontStr:  // do not
        return (false, result.acc)
      default:  // there is no try
        return (
          result.enabled,
          result.enabled ? result.acc + (Int(match.1!)! * Int(match.2!)!) : result.acc
        )
      }
    }.acc
  }
}
