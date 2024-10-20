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

func firstThenLowerCase(
    of strings: [String], satisfying predicate: (String) -> Bool
) -> String? {
    return strings.first(where: predicate)?.lowercased()
}

struct Sayer {
    let phrase: String
    func and(_ word: String) -> Sayer {
        return Sayer(phrase: "\(self.phrase) \(word)")
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}

func meaningfulLineCount(_ filename: String) async -> Result<Int, Error> {
    var count = 0
    do {
        let url = URL(fileURLWithPath: filename)
        for try await line in url.lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if !trimmed.isEmpty && !trimmed.hasPrefix("#") {
                count += 1
            }
        }
        return .success(count)
    } catch {
        return .failure(NoSuchFileError())
    }
}

struct Quaternion: CustomStringConvertible, Equatable {
    let a: Double
    let b: Double
    let c: Double
    let d: Double

    static let ZERO = Quaternion()
    static let I = Quaternion(b: 1)
    static let J = Quaternion(c: 1)
    static let K = Quaternion(d: 1)

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    var coefficients: [Double] {
        return [self.a, self.b, self.c, self.d]
    }

    var conjugate: Quaternion {
        return Quaternion(a: self.a, b: -self.b, c: -self.c, d: -self.d)
    }


    static func +(q1: Quaternion, q2: Quaternion) -> Quaternion {
        return Quaternion(
            a: q1.a + q2.a,
            b: q1.b + q2.b,
            c: q1.c + q2.c,
            d: q1.d + q2.d
        )
    }

    static func *(q1: Quaternion, q2: Quaternion) -> Quaternion {
        return Quaternion(
            a: q2.a * q1.a - q2.b * q1.b - q2.c * q1.c - q2.d * q1.d,
            b: q2.a * q1.b + q2.b * q1.a - q2.c * q1.d + q2.d * q1.c,
            c: q2.a * q1.c + q2.b * q1.d + q2.c * q1.a - q2.d * q1.b,
            d: q2.a * q1.d - q2.b * q1.c + q2.c * q1.b + q2.d * q1.a
        )
    }

    var description: String {
        var s = ""
        for (c, unit) in zip(self.coefficients, ["", "i", "j", "k"]) where c != 0 {
            s += c < 0 ? "-" : s == "" ? "" : "+"
            s += abs(c) == 1 && unit != "" ? "" : String(abs(c))
            s += unit
        }
        return s.isEmpty ? "0" : s
    }
}

enum BinarySearchTree: CustomStringConvertible {
    case empty
    indirect case node(String, BinarySearchTree, BinarySearchTree)

    var size: Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, left, right):
            return left.size + right.size + 1
        }
    }

    func insert(_ data: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(data, .empty, .empty)
        case let .node(selfData, left, right):
            if data < selfData {
                return .node(selfData, left.insert(data), right)
            } else if data > selfData {
                return .node(selfData, left, right.insert(data))
            }
            return self
        }
    }

    func contains(_ data: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(selfData, left, right):
            if data < selfData {
                return left.contains(data)
            } else if data > selfData {
                return right.contains(data)
            }
            return true
        }
    }

    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(data, left, right):
            return "(\(left)\(data)\(right))".replacingOccurrences(of: "()", with: "")
        }
    }
}