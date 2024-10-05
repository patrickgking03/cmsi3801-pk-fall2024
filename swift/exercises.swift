import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// Write your first then lower case function here
func firstThenLowerCase(of list: [String], satisfying predicate: (String) -> Bool) -> String? {
    return list.first(where: predicate)?.lowercased()
}

// Write your say function here
class Say {
    private var phraseBuilder: String = ""
    
    init(_ phrase: String = "") {
        self.phraseBuilder = phrase
    }
    
    func and(_ nextPart: String) -> Say {
        phraseBuilder += phraseBuilder.isEmpty ? nextPart : " \(nextPart)"
        return self
    }
    
    var phrase: String {
        return phraseBuilder
    }
}

func say() -> Say {
    return Say()
}

func say(_ phrase: String) -> Say {
    return Say(phrase)
}

// Write your meaningfulLineCount function here
func meaningfulLineCount(_ filePath: String) async -> Result<Int, Error> {
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let content = try String(contentsOf: fileURL)
        let lineCount = content.split { $0.isNewline }.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }.count
        return .success(lineCount)
    } catch {
        return .failure(NoSuchFileError())
    }
}

// Write your Quaternion struct here
struct Quaternion: Equatable {
    var a: Double
    var b: Double
    var c: Double
    var d: Double
    
    static let ZERO = Quaternion(a: 0, b: 0, c: 0, d: 0)
    static let I = Quaternion(a: 0, b: 1, c: 0, d: 0)
    static let J = Quaternion(a: 0, b: 0, c: 1, d: 0)
    static let K = Quaternion(a: 0, b: 0, c: 0, d: 1)
    
    func conjugate() -> Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }
    
    var coefficients: [Double] {
        return [a, b, c, d]
    }
    
    static func +(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }
    
    static func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
            b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
            c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
            d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        )
    }
    
    static func ==(lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c && lhs.d == rhs.d
    }
    
    var description: String {
        var result = ""
        if a != 0 { result += "\(a)" }
        if b != 0 { result += (b > 0 && !result.isEmpty ? "+" : "") + "\(b)i" }
        if c != 0 { result += (c > 0 && !result.isEmpty ? "+" : "") + "\(c)j" }
        if d != 0 { result += (d > 0 && !result.isEmpty ? "+" : "") + "\(d)k" }
        return result.isEmpty ? "0" : result
    }
}

// Write your Binary Search Tree enum here
enum BinarySearchTree {
    case empty
    indirect case node(String, BinarySearchTree, BinarySearchTree)
    
    func insert(_ newValue: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(newValue, .empty, .empty)
        case let .node(value, left, right):
            if newValue < value {
                return .node(value, left.insert(newValue), right)
            } else if newValue > value {
                return .node(value, left, right.insert(newValue))
            } else {
                return self
            }
        }
    }
    
    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(nodeValue, left, right):
            if value == nodeValue {
                return true
            } else if value < nodeValue {
                return left.contains(value)
            } else {
                return right.contains(value)
            }
        }
    }
    
    var size: Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, left, right):
            return 1 + left.size + right.size
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(value, left, right):
            return "(\(left)\(value)\(right))"
        }
    }
}
