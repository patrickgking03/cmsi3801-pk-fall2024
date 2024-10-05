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

// firstThenLowerCase function
fun firstThenLowerCase(list: List<String>, predicate: (String) -> Boolean): String? {
    return list.firstOrNull(predicate)?.toLowerCase()  // Fixed typo
}

// say function
class Say(private var phraseBuilder: String = "") {
    fun and(nextPart: String): Say {
        phraseBuilder += if (phraseBuilder.isEmpty()) nextPart else " $nextPart"
        return this
    }

    val phrase: String
        get() = phraseBuilder
}

fun say(): Say = Say()
fun say(initialPhrase: String): Say = Say(initialPhrase)

// meaningfulLineCount function
fun meaningfulLineCount(filePath: String): Long {
    BufferedReader(FileReader(filePath)).use { reader ->
        return reader.lineSequence().filter { it.isNotBlank() }.count().toLong()
    }
}

// Quaternion data class
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    init {
        require(!a.isNaN() && !b.isNaN() && !c.isNaN() && !d.isNaN()) {
            "Coefficients cannot be NaN"
        }
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)
    }

    operator fun times(other: Quaternion): Quaternion {
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        )
    }

    fun conjugate(): Quaternion = Quaternion(a, -b, -c, -d)

    fun coefficients(): List<Double> = listOf(a, b, c, d)

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }
}

// Binary Search Tree
sealed class BinarySearchTree {
    abstract fun insert(value: String): BinarySearchTree
    abstract fun contains(value: String): Boolean
    abstract fun size(): Int

    object Empty : BinarySearchTree() {
        override fun insert(value: String): BinarySearchTree {
            return Node(value, Empty, Empty)
        }

        override fun contains(value: String): Boolean = false
        override fun size(): Int = 0
        override fun toString(): String = "()"
    }

    data class Node(val value: String, val left: BinarySearchTree, val right: BinarySearchTree) : BinarySearchTree() {
        override fun insert(newValue: String): BinarySearchTree {
            return when {
                newValue < value -> Node(value, left.insert(newValue), right)
                newValue > value -> Node(value, left, right.insert(newValue))
                else -> this // Value is already present
            }
        }

        override fun contains(value: String): Boolean {
            return when {
                value == this.value -> true
                value < this.value -> left.contains(value)
                else -> right.contains(value)
            }
        }

        override fun size(): Int = 1 + left.size() + right.size()
        override fun toString(): String = "($left$value$right)"
    }
}
