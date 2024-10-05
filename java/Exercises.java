import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    // firstThenLowerCase method
    public static Optional<String> firstThenLowerCase(List<String> list, Predicate<String> predicate) {
        return list.stream()
                   .filter(predicate)
                   .map(String::toLowerCase)
                   .findFirst();
    }

    // meaningfulLineCount method
    public static long meaningfulLineCount(String filePath) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            return reader.lines()
                         .filter(line -> !line.trim().isEmpty())
                         .count();
        }
    }

    // say method
    public static Say say() {
        return new Say("");
    }

    public static Say say(String phrase) {
        return new Say(phrase);
    }

    public static class Say {
        private String phrase;

        public Say(String phrase) {
            this.phrase = phrase;
        }

        public Say and(String nextPart) {
            this.phrase += " " + nextPart;
            return this;
        }

        public String phrase() {
            return this.phrase;
        }
    }

    // Quaternion class
    public static record Quaternion(double a, double b, double c, double d) {

        public Quaternion {
            if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
                throw new IllegalArgumentException("Coefficients cannot be NaN");
            }
        }

        public Quaternion plus(Quaternion other) {
            return new Quaternion(this.a + other.a, this.b + other.b, this.c + other.c, this.d + other.d);
        }

        public Quaternion times(Quaternion other) {
            return new Quaternion(
                this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
                this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
                this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
                this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
            );
        }

        public Quaternion conjugate() {
            return new Quaternion(a, -b, -c, -d);
        }

        public List<Double> coefficients() {
            return List.of(a, b, c, d);
        }

        @Override
        public String toString() {
            StringBuilder result = new StringBuilder();
            if (a != 0) result.append(a);
            if (b != 0) result.append((b > 0 && result.length() > 0 ? "+" : "")).append(b).append("i");
            if (c != 0) result.append((c > 0 && result.length() > 0 ? "+" : "")).append(c).append("j");
            if (d != 0) result.append((d > 0 && result.length() > 0 ? "+" : "")).append(d).append("k");
            return result.toString().isEmpty() ? "0" : result.toString();
        }

        public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
        public static final Quaternion I = new Quaternion(0, 1, 0, 0);
        public static final Quaternion J = new Quaternion(0, 0, 1, 0);
        public static final Quaternion K = new Quaternion(0, 0, 0, 1);
    }

    // BinarySearchTree
    public sealed interface BinarySearchTree permits Empty, Node {
        BinarySearchTree insert(String value);
        boolean contains(String value);
        int size();
    }

    public static final class Empty implements BinarySearchTree {
        @Override
        public BinarySearchTree insert(String value) {
            return new Node(value, this, this);
        }

        @Override
        public boolean contains(String value) {
            return false;
        }

        @Override
        public int size() {
            return 0;
        }

        @Override
        public String toString() {
            return "()";
        }
    }

    public static final class Node implements BinarySearchTree {
        private final String value;
        private final BinarySearchTree left, right;

        public Node(String value, BinarySearchTree left, BinarySearchTree right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }

        @Override
        public BinarySearchTree insert(String newValue) {
            if (newValue.compareTo(value) < 0) {
                return new Node(value, left.insert(newValue), right);
            } else if (newValue.compareTo(value) > 0) {
                return new Node(value, left, right.insert(newValue));
            } else {
                return this;
            }
        }

        @Override
        public boolean contains(String value) {
            if (value.equals(this.value)) {
                return true;
            } else if (value.compareTo(this.value) < 0) {
                return left.contains(value);
            } else {
                return right.contains(value);
            }
        }

        @Override
        public int size() {
            return 1 + left.size() + right.size();
        }

        @Override
        public String toString() {
            return "(" + left + value + right + ")";
        }
    }
}