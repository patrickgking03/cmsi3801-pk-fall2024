import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

fun firstThenLowerCase(strings: List<String>, predicate: (String) -> Boolean): String? {
    return strings.firstOrNull(predicate)?.lowercase()
}

data class Sayer(val phrase: String) {
    fun and(word: String): Sayer = Sayer("$phrase $word")
}

fun say(word: String = ""): Sayer = Sayer(word)

@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
    BufferedReader(FileReader(filename)).useLines { lines ->
        return lines.map(String::trim)
            .filter { it.isNotBlank() && !it.startsWith("#") }
            .count()
            .toLong()
    }
}

data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    init {
        require(!(a.isNaN() || b.isNaN() || c.isNaN() || d.isNaN())) {
            "Coefficients cannot be NaN"
        }
    }

    operator fun plus(q: Quaternion) = Quaternion(a + q.a, b + q.b, c + q.c, d + q.d)

    operator fun times(q: Quaternion) = Quaternion(
        q.a * a - q.b * b - q.c * c - q.d * d,
        q.a * b + q.b * a - q.c * d + q.d * c,
        q.a * c + q.b * d + q.c * a - q.d * b,
        q.a * d - q.b * c + q.c * b + q.d * a
    )

    fun conjugate() = Quaternion(a, -b, -c, -d)

    fun coefficients() = listOf(a, b, c, d)

    override fun toString(): String {
        val units = listOf("", "i", "j", "k")
        return coefficients().zip(units).fold(StringBuilder()) { sb, (c, unit) ->
            if (c != 0.0) {
                sb.append(if (c < 0) "-" else if (sb.length > 0) "+" else "");
                sb.append(if (Math.abs(c) != 1.0 || unit.isEmpty()) Math.abs(c) else "");
                sb.append(unit)
            }
            sb
        }.toString().ifEmpty { "0" }
    }
}

sealed interface BinarySearchTree {
    fun size(): Int
    fun insert(data: String): BinarySearchTree
    fun contains(data: String): Boolean

    object Empty : BinarySearchTree {
        override fun size() = 0
        override fun insert(data: String): BinarySearchTree {
            return Node(data, Empty, Empty)
        }
        override fun contains(data: String) = false
        override fun toString() = "()"
    }

    data class Node(
        private val data: String,
        private val left: BinarySearchTree,
        private val right: BinarySearchTree
    ) : BinarySearchTree {
        override fun size() = left.size() + right.size() + 1
        override fun insert(data: String): BinarySearchTree {
            return when {
                data < this.data -> Node(this.data, left.insert(data), right)
                data > this.data -> Node(this.data, left, right.insert(data))
                else -> this
            }
        }
        override fun contains(data: String): Boolean {
            return when {
                data < this.data -> left.contains(data)
                data > this.data -> right.contains(data)
                else -> true
            }
        }
        override fun toString(): String {
            return ("($left$data$right)").replace("()", "")
        }
    }
}
