import { createReadStream } from 'fs';
import * as readline from 'readline';
import { open } from "node:fs/promises"

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then apply function here
export function firstThenApply<T, U>(
  arr: T[],
  predicate: (item: T) => boolean,
  func: (item: T) => U
): U | undefined {
  const found = arr.find(predicate);
  return found !== undefined ? func(found) : undefined;
}

// Write your powers generator here
export function* powersGenerator(base: bigint): Generator<bigint> {
  let current = 1n;
  while (true) {
    yield current;
    current *= base;
  }
}

// Write your line count function here
export async function meaningfulLineCount(filePath: string): Promise<number> {
  const fileStream = createReadStream(filePath);
  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
  });
  let count = 0;
  for await (const line of rl) {
    if (line.trim() && !line.trim().startsWith('#')) count++;
  }
  return count;
}

// Write your shape type and associated functions here
type Box = { kind: "Box"; width: number; length: number; depth: number };
type Sphere = { kind: "Sphere"; radius: number };
export type Shape = Box | Sphere;
export function volume(shape: Shape): number {
  if (shape.kind === "Sphere") {
    return (4 / 3) * Math.PI * Math.pow(shape.radius, 3);
  } else {
    return shape.width * shape.length * shape.depth;
  }
}
export function surfaceArea(shape: Shape): number {
  if (shape.kind === "Sphere") {
    return 4 * Math.PI * Math.pow(shape.radius, 2);
  } else {
    return 2 * (shape.width * shape.length + shape.width * shape.depth + shape.length * shape.depth);
  }
}

// Write your binary search tree implementation here
export interface BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T>;
  contains(value: T): boolean;
  size(): number;
  inorder(): Generator<T>;
  toString(): string;
}

class Node<T> implements BinarySearchTree<T> {
  left: BinarySearchTree<T>;
  right: BinarySearchTree<T>;
  value: T;
  constructor(value: T, left: BinarySearchTree<T> = new Empty(), right: BinarySearchTree<T> = new Empty()) {
    this.value = value;
    this.left = left;
    this.right = right;
  }
  insert(value: T): BinarySearchTree<T> {
    if (value < this.value) {
      return new Node(this.value, this.left.insert(value), this.right);
    } else if (value > this.value) {
      return new Node(this.value, this.left, this.right.insert(value));
    } else {
      return this;
    }
  }
  contains(value: T): boolean {
    if (value === this.value) return true;
    if (value < this.value) return this.left.contains(value);
    return this.right.contains(value);
  }
  size(): number {
    return 1 + this.left.size() + this.right.size();
  }
  *inorder(): Generator<T> {
    yield* this.left.inorder();
    yield this.value;
    yield* this.right.inorder();
  }
  toString(): string {
    const leftStr = this.left.toString();
    const rightStr = this.right.toString();
    return `(${leftStr}${this.value}${rightStr})`;
  }
}

class Empty<T> implements BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T> {
    return new Node(value);
  }
  contains(value: T): boolean {
    return false;
  }
  size(): number {
    return 0;
  }
  *inorder(): Generator<T> {}
  toString(): string {
    return "";
  }
}
export { Node, Empty };