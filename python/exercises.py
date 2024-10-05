from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts

# Write your first then lower case function here
def first_then_lower_case(strings: list[str], predicate: Callable[[str], bool]) -> str | None:
    for string in strings:
        if predicate(string):
            return string.lower()
    return None

# Write your powers generator here
def powers_generator(*, base: int, limit: int):
    power = 1
    while power <= limit:
        yield power
        power *= base

# Write your say function here
def say(word: str = '') -> Callable[..., str]:
    sentence = word

    def next_word(next: str = None) -> Callable[..., str]:
        nonlocal sentence
        if next is None:
            return sentence.strip()
        if next == '':
            sentence += ' '
        else:
            sentence += ' ' + next
        return next_word

    return next_word

# Write your line count function here
def meaningful_line_count(filename: str) -> int:
    try:
        with open(filename, 'r') as file:
            return sum(1 for line in file if line.strip() and not line.lstrip().startswith('#'))
    except FileNotFoundError:
        raise FileNotFoundError('No such file')

# Write your Quaternion class here
@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float

    @property
    def coefficients(self) -> tuple[float, float, float, float]:
        return self.a, self.b, self.c, self.d

    @property
    def conjugate(self) -> 'Quaternion':
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    def __add__(self, other: 'Quaternion') -> 'Quaternion':
        return Quaternion(
            self.a + other.a,
            self.b + other.b,
            self.c + other.c,
            self.d + other.d
        )

    def __mul__(self, other: 'Quaternion') -> 'Quaternion':
        a = self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d
        b = self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c
        c = self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b
        d = self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        return Quaternion(a, b, c, d)

    def __eq__(self, other: 'Quaternion') -> bool:
        return (
            self.a == other.a and
            self.b == other.b and
            self.c == other.c and
            self.d == other.d
        )

    def __str__(self) -> str:
        components = []
        if self.a != 0:
            components.append(f"{self.a}")
        if self.b != 0:
            components.append(f"{'+' if self.b > 0 else ''}{self.b}i" if abs(self.b) != 1 else ('i' if self.b == 1 else '-i'))
        if self.c != 0:
            components.append(f"{'+' if self.c > 0 else ''}{self.c}j" if abs(self.c) != 1 else ('j' if self.c == 1 else '-j'))
        if self.d != 0:
            components.append(f"{'+' if self.d > 0 else ''}{self.d}k" if abs(self.d) != 1 else ('k' if self.d == 1 else '-k'))
        return ''.join(components) if components else '0'