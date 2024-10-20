import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

export function firstThenLowerCase(strings, predicate) {
  return strings.find(predicate)?.toLowerCase()
}

export function* powersGenerator({ ofBase: base, upTo: limit }) {
  for (let power = 1; power <= limit; power *= base) {
    yield power
  }
}

export function say(first) {
  if (first === undefined) {
    return ""
  }
  return (second) => {
    if (second === undefined) {
      return first
    }
    return say(`${first} ${second}`)
  }
}

export async function meaningfulLineCount(filename) {
  let count = 0
  const file = await open(filename, "r")
  for await (const line of file.readLines()) {
    // Note that readLines will autoclose the file, yay
    const trimmed = line.trim()
    if (trimmed && !trimmed.startsWith("#")) {
      count++
    }
  }
  return count
}

export class Quaternion {
  constructor(a, b, c, d) {
    Object.assign(this, { a, b, c, d })
    return Object.freeze(this)
  }
  plus(q) {
    return new Quaternion(
      this.a + q.a,
      this.b + q.b,
      this.c + q.c,
      this.d + q.d
    )
  }
  times(q) {
    return new Quaternion(
      q.a * this.a - q.b * this.b - q.c * this.c - q.d * this.d,
      q.a * this.b + q.b * this.a - q.c * this.d + q.d * this.c,
      q.a * this.c + q.b * this.d + q.c * this.a - q.d * this.b,
      q.a * this.d - q.b * this.c + q.c * this.b + q.d * this.a
    )
  }
  equals(q) {
    return this.a === q.a && this.b === q.b && this.c === q.c && this.d === q.d
  }
  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d)
  }
  get coefficients() {
    return [this.a, this.b, this.c, this.d]
  }
  toString() {
    let s = ""
    for (const [i, c] of this.coefficients.entries()) {
      if (c === 0) continue
      s += c < 0 ? "-" : s == "" ? "" : "+"
      if (Math.abs(c) !== 1 || i === 0) s += Math.abs(c)
      s += ["", "i", "j", "k"][i]
    }
    return s || "0"
  }
}