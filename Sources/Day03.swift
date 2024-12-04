import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  var data: String

  static var mulOp: Regex<(Substring, Int, Int)> {
    Regex {
      "mul("
      Capture(
        {
          OneOrMore(.digit)
        },
        transform: {
          Int($0)!
        })
      ","
      Capture(
        {
          OneOrMore(.digit)
        },
        transform: {
          Int($0)!
        })
      ")"
    }
  }

  func part1() -> Any {
    return data.matches(of: Self.mulOp).reduce(0) { acc, m in
      acc + (m.1 * m.2)
    }
  }

  func part2() -> Any {
    let doStr = "do()"
    let dontStr = "don't()"

    let pattern = Regex {
      ChoiceOf {
        Regex { doStr }
        Regex { dontStr }
        Self.mulOp
      }
    }

    return data.matches(of: pattern).reduce((enabled: true, acc: 0)) { result, match in
      switch match.0 {
      case doStr: (true, result.acc)  // do
      case dontStr: (false, result.acc)  // do not
      default:  // there is no try
        (
          result.enabled,
          result.enabled ? result.acc + (match.1! * match.2!) : result.acc
        )
      }
    }.acc
  }
}
