import { open, readFile } from 'node:fs/promises'; // Keep this as it is

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer");
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative");
  }
  let [counts, remaining] = [{}, amount];
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination);
    remaining %= denomination;
  }
  return counts;
}

// Write your first then lower case function here
export function firstThenLowerCase(array, predicate) {
  for (const item of array) {
    if (predicate(item)) {
      return item.toLowerCase();
    }
  }
  return undefined;
}

// Write your powers generator here
export function* powersGenerator({ ofBase, upTo }) {
  let power = 1;

  while (power <= upTo) {
    yield power;
    power *= ofBase;
  }
}

// Write your say function here
export function say(word = '') {
  if (word === '') {
    return '';
  }

  let sentence = word;

  return function(nextWord) {
    if (nextWord === undefined) {
      return sentence;
    }

    sentence += nextWord ? ` ${nextWord}` : ' ';
    return say(sentence);
  };
}

// Write your line count function here
import { readFile } from 'fs/promises';
export async function meaningfulLineCount(filename) {
  try {
    const content = await readFile(filename, 'utf-8'); 
    const lines = content.split('\n');

    return lines.filter(line => line.trim() !== '' && !line.trim().startsWith('#')).length;
  } catch (error) {
    throw new Error('No such file');
  }
}

// Write your Quaternion class here
export class Quaternion {
  constructor(a, b, c, d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;

    Object.freeze(this);
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d];
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  add(q) {
    return new Quaternion(
      this.a + q.a, 
      this.b + q.b, 
      this.c + q.c, 
      this.d + q.d
    );
  }

  plus(q) {
    return this.add(q);
  }

  multiply(q) {
    return new Quaternion(
      this.a * q.a - this.b * q.b - this.c * q.c - this.d * q.d,
      this.a * q.b + this.b * q.a + this.c * q.d - this.d * q.c,
      this.a * q.c - this.b * q.d + this.c * q.a + this.d * q.b,
      this.a * q.d + this.b * q.c - this.c * q.b + this.d * q.a
    );
  }

  times(q) {
    return this.multiply(q);
  }

  equals(q) {
    return this.a === q.a && this.b === q.b && this.c === q.c && this.d === q.d;
  }

  toString() {
    const parts = [];

    if (this.a !== 0) parts.push(`${this.a}`);
    if (this.b !== 0) parts.push(`${this.b > 0 && parts.length ? '+' : ''}${this.b === 1 ? '' : this.b === -1 ? '-' : this.b}i`);
    if (this.c !== 0) parts.push(`${this.c > 0 && parts.length ? '+' : ''}${this.c === 1 ? '' : this.c === -1 ? '-' : this.c}j`);
    if (this.d !== 0) parts.push(`${this.d > 0 && parts.length ? '+' : ''}${this.d === 1 ? '' : this.d === -1 ? '-' : this.d}k`);

    return parts.length ? parts.join('') : '0';
  }
}