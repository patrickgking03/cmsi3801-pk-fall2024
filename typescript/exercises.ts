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

export function firstThenApply<T, U>(
  array: T[],
  predicate: (x: T) => boolean,
  consumer: (x: T) => U | undefined
): U | undefined {
  const first = array.find(predicate)
  if (first) {
    return consumer(first)
  }
  return undefined
}

export function* powersGenerator(base: bigint): Generator<bigint> {
  for (let power = 1n; true; power *= base) {
    yield power
  }
}

export async function meaningfulLineCount(filename: string): Promise<number> {
  let count = 0
  const file = await open(filename, "r")
  for await (const line of file.readLines()) {
    const trimmed = line.trim()
    if (trimmed && !trimmed.startsWith("#")) {
      count++
    }
  }
  return count
}

interface Sphere {
  kind: "Sphere"
  radius: number
}

interface Box {
  kind: "Box"
  width: number
  length: number
  depth: number
}

export type Shape = Sphere | Box

export function volume(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return (4 / 3) * Math.PI * shape.radius ** 3
    case "Box":
      return shape.width * shape.length * shape.depth
  }
}

export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return 4 * Math.PI * shape.radius ** 2
    case "Box":
      const { length, width, depth } = shape
      return 2 * (length * width + length * depth + width * depth)
  }
}

export interface BinarySearchTree<T> {
  size(): number
  insert(data: T): BinarySearchTree<T>
  contains(data: T): boolean
  inorder(): Iterable<T>
}

export class Empty<T> implements BinarySearchTree<T> {
  size(): number {
    return 0
  }
  insert(data: T): BinarySearchTree<T> {
    return new Node<T>(data, new Empty<T>(), new Empty<T>())
  }
  contains(data: T): boolean {
    return false
  }
  *inorder(): Iterable<T> {}
  toString(): string {
    return "()"
  }
}

class Node<T> implements BinarySearchTree<T> {
  constructor(
    private data: T,
    private left: BinarySearchTree<T>,
    private right: BinarySearchTree<T>
  ) {}

  size(): number {
    return this.left.size() + this.right.size() + 1
  }

  insert(data: T): BinarySearchTree<T> {
    if (data < this.data) {
      return new Node(this.data, this.left.insert(data), this.right)
    } else if (data > this.data) {
      return new Node(this.data, this.left, this.right.insert(data))
    } else {
      return this
    }
  }

  contains(data: T): boolean {
    if (data < this.data) {
      return this.left.contains(data)
    } else if (data > this.data) {
      return this.right.contains(data)
    } else {
      return true
    }
  }

  *inorder(): Iterable<T> {
    yield* this.left.inorder()
    yield this.data
    yield* this.right.inorder()
  }

  toString(): string {
    return `(${this.left}${this.data}${this.right})`.replaceAll("()", "")
  }
}