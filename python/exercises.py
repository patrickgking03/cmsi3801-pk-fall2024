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


def first_then_lower_case(s: list[str], p: Callable[[str],bool], /) -> str:
    first = next((word for word in s if p(word)), '')
    return first.lower() if first else None


def powers_generator(*, base: int, limit: int):
    power = 1
    while power <= limit:
        yield power
        power *= base


def say(word: str|None=None, /):
    if word is None:
        return ''
    return lambda next=None: word if next is None else say(f'{word} {next}')


def meaningful_line_count(filename: str, /) -> int:
    count = 0
    with open(filename, 'r', encoding='utf-8') as file:
        for line in file:
            line = line.strip()
            if line and not line.startswith('#'):
                count += 1
    return count


@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float
    def __add__(self, q: 'Quaternion') -> 'Quaternion':
        return Quaternion(self.a + q.a, self.b + q.b, self.c + q.c, self.d + q.d)
    def __mul__(self, q: 'Quaternion') -> 'Quaternion':
        return Quaternion(
            q.a * self.a - q.b * self.b - q.c * self.c - q.d * self.d,
            q.a * self.b + q.b * self.a - q.c * self.d + q.d * self.c,
            q.a * self.c + q.b * self.d + q.c * self.a - q.d * self.b,
            q.a * self.d - q.b * self.c + q.c * self.b + q.d * self.a)
    @property
    def coefficients(self) -> tuple[float, float, float, float]:
        return (self.a, self.b, self.c, self.d)
    @property
    def conjugate(self) -> 'Quaternion':
        return Quaternion(self.a, -self.b, -self.c, -self.d)
    def __repr__(self) -> str:
        s = ""
        for c, unit in zip(self.coefficients, ["", "i", "j", "k"]):
            if c == 0: continue
            s += '-' if c < 0 else '' if s == '' else '+'
            s += '' if abs(c) == 1 and unit != "" else str(abs(c))
            s += unit
        return '0' if s == '' else s