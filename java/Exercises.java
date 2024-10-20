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

    static Optional<String> firstThenLowerCase(
            List<String> strings, Predicate<String> predicate) {
        return strings.stream()
                .filter(predicate)
                .findFirst()
                .map(String::toLowerCase);
    }

    static record Sayer(String phrase) {
        Sayer and(String word) {
            return new Sayer(phrase + ' ' + word);
        }
    }

    static Sayer say() {
        return new Sayer("");
    }

    static Sayer say(String word) {
        return new Sayer(word);
    }

    static long meaningfulLineCount(String filename) throws IOException {
        try (var reader = new BufferedReader(new FileReader(filename))) {
             return reader.lines()
                .map(String::trim)
                .filter(line -> !line.isBlank() && !line.startsWith("#"))
                .count();
        }
    }
}

record Quaternion(double a, double b, double c, double d) {

    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K = new Quaternion(0, 0, 0, 1);

    public Quaternion {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    public Quaternion plus(Quaternion q) {
        return new Quaternion(a + q.a, b + q.b, c + q.c, d + q.d);
    }

    public Quaternion times(Quaternion q) {
        return new Quaternion(
                q.a * a - q.b * b - q.c * c - q.d * d,
                q.a * b + q.b * a - q.c * d + q.d * c,
                q.a * c + q.b * d + q.c * a - q.d * b,
                q.a * d - q.b * c + q.c * b + q.d * a);
    }

    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    public List<Double> coefficients() {
        return List.of(a, b, c, d);
    }

    @Override public String toString() {
        var builder = new StringBuilder();
        var units = new String[]{"", "i", "j", "k"};
        for (var i = 0; i < units.length; i++) {
            var unit = units[i];
            var c = coefficients().get(i);
            if (c == 0) continue;
            builder.append(c < 0 ? "-" : builder.length() > 0 ? "+" : "");
            builder.append(Math.abs(c) != 1 || unit.isEmpty() ? Math.abs(c) : "");
            builder.append(unit);
        }
        return builder.isEmpty() ? "0" : builder.toString();
    }
}

sealed interface BinarySearchTree permits Empty, Node {
    int size();
    BinarySearchTree insert(String data);
    boolean contains(String data);
}

final record Empty() implements BinarySearchTree {
    @Override public int size() {
        return 0;
    }

    @Override public BinarySearchTree insert(String data) {
        return new Node(data, this, this);
    }

    @Override public boolean contains(String data) {
        return false;
    }

    @Override public String toString() {
        return "()";
    }
}

final record Node (
        String data, BinarySearchTree left, BinarySearchTree right)
        implements BinarySearchTree {
    @Override public int size() {
        return left.size() + right.size() + 1;
    }

    @Override public BinarySearchTree insert(String data) {
        if (data.compareTo(this.data) < 0) {
            return new Node(this.data, left.insert(data), right);
        } else if (data.compareTo(this.data) > 0) {
            return new Node(this.data, left, right.insert(data));
        } else {
            return this;
        }
    }

    @Override public boolean contains(String data) {
        if (data.compareTo(this.data) < 0) {
            return left.contains(data);
        } else if (data.compareTo(this.data) > 0) {
            return right.contains(data);
        } else {
            return true;
        }
    }

    @Override public String toString() {
        return ("(" + left + data + right + ")").replace("()", "");
    }
}