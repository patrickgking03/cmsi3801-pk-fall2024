# **CMSI 3801: Homework Folder**  
### **By Patrick King**  
### **Fall 2024 – Languages and Automata I**  

---

## **Welcome!**

This repository contains my submissions for CMSI 3801 homework assignments. Below, you’ll find detailed descriptions of each assignment, including the tasks completed and the languages used.  

---

## **Homework Submissions**

### **Homework 1 (Scripting):** Lua, Python, JavaScript  
- **Status:** Completed  
- **Group Members:** Patrick King  
- **Description:**  
  This assignment focused on scripting across three languages with tasks like filtering collections, creating generators, and building chainable functions. Implemented parsers to count meaningful lines and modeled Quaternions with operations like addition and multiplication. It was a great introduction to the unique paradigms and idioms of each language, especially their handling of closures and asynchronous behavior.  

---

### **Homework 2 (Enterprise):** Java, Kotlin, Swift  
- **Status:** Completed  
- **Group Members:** Patrick King   
- **Description:**  
  This assignment explored object-oriented programming concepts in Java, Kotlin, and Swift. I worked on chainable objects, file parsers, and immutable binary search trees, applying principles like encapsulation and inheritance. The implementation of Quaternions as immutable classes highlighted the differences in design philosophy between these enterprise-focused languages.  

---

### **Homework 3 (Theory):** TypeScript, OCaml, Haskell  
- **Status:** Completed  
- **Group Members:** Patrick King  
- **Description:**  
  This assignment emphasized functional programming with tasks in TypeScript, OCaml, and Haskell. I built polymorphic functions, infinite sequences, and persistent binary search trees using algebraic data types. It was a great opportunity to apply concepts like immutability, recursion, and type safety across three distinctly typed functional languages.  

---

### **Homework 4 (Systems):** C, C++, Rust  
- **Status:** Completed  
- **Group Members:** Patrick King  
- **Description:**  
  This assignment involved implementing stack data structures in C, C++, and Rust with a focus on memory management. Tasks included resizing arrays efficiently and ensuring safety through Rust’s model. It highlighted the challenges and benefits of manual memory management in low-level systems programming.  

---

### **Homework 5 (Concurrency):** Go  
- **Status:** Completed  
- **Group Members:** Patrick King  
- **Description:**  
  This assignment involves creating a restaurant simulation in Go to model concurrent processes like customers placing orders and cooks preparing meals. The focus is on managing concurrency with goroutines, channels, and timeouts. It provides hands-on experience with Go’s lightweight concurrency model and synchronization tools.  

---

## **The Test Suites**

The test suites are run like so:

### Lua

```
lua exercises_test.lua
```

### Python

```
python3 exercises_test.py
```

### JavaScript

```
npm test
```

### Java

```
javac *.java && java ExercisesTest
```

### Kotlin

```
kotlinc *.kt -include-runtime -d test.jar && java -jar test.jar
```

### Swift

```
swiftc -o main exercises.swift main.swift && ./main
```

### TypeScript

```
npm test
```

### OCaml

```
ocamlc exercises.ml exercises_test.ml && ./a.out
```

### Haskell

```
ghc ExercisesTest.hs && ./ExercisesTest
```

### C

```
gcc string_stack.c string_stack_test.c && ./a.out
```

### C++

```
g++ -std=c++20 stack_test.cpp && ./a.out
```

### Rust

```
cargo test
```

### Go

```
go run restaurant.go
```
