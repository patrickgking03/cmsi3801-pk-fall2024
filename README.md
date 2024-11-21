# Homework Folder for CMSI 3801
### By Patrick King
### Fall 2024
### Languages and Automata I

Welcome!

## Instructions

Fork this repo for your homework submissions. Make sure your fork has a nice, descriptive name. Leaving the name as “lmu-cmsi-3801-template” is misleading, and keeping it indicates you are not taking sufficient pride in your work. After forking, **please replace the contents of this readme** file with information about your submissions, including the name(s) of the students, and a description of each assignment (as they are turned in).

Don’t bother with notes to the graders. Such notes go into your BrightSpace submissions, not your GitHub repository.

Your homework submissions will consist of programs in the following languages. To keep things simple, there is a separate folder for each language.

- **Homework 1 (Scripting)**: Lua, Python, JavaScript
    - Status: **Completed**
    - Group Members: **Patrick King**
    - Updates: **Correct Solutions Added**
    - Description: This assignment focused on scripting across three languages with tasks like filtering collections, creating generators, and building chainable functions. Implemented parsers to count meaningful lines and modeled Quaternions with operations like addition and multiplication. It was a great introduction to the unique paradigms and idioms of each language, especially their handling of closures and asynchronous behavior.
- **Homework 2 (Enterprise)**: Java, Kotlin, Swift
    - Status: **Completed**
    - Group Members: **Patrick King**
    - Updates: **Correct Solutions Added**
    - Description: This assignment explored object-oriented programming concepts in Java, Kotlin, and Swift. I worked on chainable objects, file parsers, and immutable binary search trees, applying principles like encapsulation and inheritance. The implementation of Quaternions as immutable classes highlighted the differences in design philosophy between these enterprise-focused languages.
- **Homework 3 (Theory)**: TypeScript, OCaml, Haskell
    - Status: **Completed**
    - Group Members: **Patrick King**
    - Updates: **Correct Solutions Added**
    - Description: This assignment emphasized functional programming with tasks in TypeScript, OCaml, and Haskell. I built polymorphic functions, infinite sequences, and persistent binary search trees using algebraic data types. It was a great opportunity to apply concepts like immutability, recursion, and type safety across three distinctly typed functional languages.
- **Homework 4 (Systems)**: C, C++, Rust
    - Status: **Completed**
    - Group Members: **Patrick King**
    - Updates: **None Yet**
    - Description: This assignment involved implementing stack data structures in C, C++, and Rust with a focus on memory management. Tasks included resizing arrays efficiently and ensuring safety through Rust’s model. It highlighted the challenges and benefits of manual memory management in low-level systems programming.
- **Homework 5 (Concurrency)**: Go
    - Status: **In Progress**
    - Group Members: **Patrick King**
    - Updates: **None Yet**
    - Description: This assignment involves creating a restaurant simulation in Go to model concurrent processes like customers placing orders and cooks preparing meals. The focus is on managing concurrency with goroutines, channels, and timeouts. It provides hands-on experience with Go’s lightweight concurrency model and synchronization tools.

At each homework deadline, the graders will clone your repo and run the tests. I will be inspecting the source code, grading your work on style, clarity, and appropriate use of language idioms. Do not throw away points in these areas: **use code formatters and linters**. Please consider it a moral obligation to use these tools. Not doing so is a violation of professional ethics. _You must respect the naming, capitalization, formatting, spacing, and indentation conventions of each language_.

## The Test Suites

The test files are included in the repo already. They are available for YOU! They will help you not only learn the languages and concepts covered in this course, but to help you with professional practice. You should get accustomed to writing code to make tests pass. As you grow in your profession, you will get used to writing your tests early.

The test suites are run like so (assuming you have a Unix-like shell, modify as necessary if you have Windows):

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

## Grading Notes

Your grade is a reflection not only of your ability to write code to pass existing tests, but also of your ability to construct software in a professional setting. Therefore, the following will contribute rather heavily to your score:

- **Following all submission instructions**! Pay attention to every requirement such as replacing the contents of this readme file and including the names of all participants of any group work.
- **Keeping a pristine GitHub repository**. Do not push any file that does not belong (including but not limited to that silly `DS_Store`). Make sure all generated executables, intermediate files, third-party libraries, etc. are not committed. Your repo contents should be limited to your solution files, tests, configuration files, and `.gitignore` files.
- **Adherence to naming and formatting conventions for the language you are writing in**. Inconsistent indentation, for example, has no place in professional or student software. Neither does end-of-line whitespace, huge chunks of contiguous blank lines, and other types of messy coding practices that show friends, family, colleagues, and potential employers that you don’t care about your work.
- (As always) The **readability and maintainability** of your code.
