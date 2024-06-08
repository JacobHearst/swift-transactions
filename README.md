# Transactions

> [!WARNING]
> This library is mostly an exploration of the concept of composable functions and I predict there will be many breaking changes and new additions as I continue my exploration. Rely on it at your own risk.

**Transactions** is a library designed to help you write logic as small, single-purpose units which can then be composed and transformed into larger, more complex features.

It does this via the `Transaction` protocol which allows you to redefine single-input functions as `struct`s which in turn get some nice fluent-style methods for transformation and composition. The library also contains a result builder DSL for a
more declarative way of building your higher order transactions.

> [!NOTE]
> This library was built with server-side Swift in mind and as a result is `async throws` first.

## Installation
Simply add this package as a dependency to your Swift Package or Xcode Project

```swift
// Package.swift

let package = Package(
  // ...
  dependencies: [
    .package(url: "https://github.com/JacobHearst/swift-transactions", branch: "main")
  ],
  targets: [
    .target(
      // ...
      dependencies: [
        .product(name: "Transactions", package: "swift-transactions"),
      ]
    )
  ]
)
```

## Usage
To create your first transaction, create a `struct` that conforms to the `Transaction` protocol:

```swift
struct LoadFile: Transaction {
  public func run(on input: URL) async throws -> Data {
    try Data(contentsOf: URL)
  }
}
```

It might seem a bit silly to create a whole new type just to call a `Data` initializer but let's see what happens when we start to define some other transactions

```swift
struct DecodeModel<T: Decodable>: Transaction {
  func run(on input: Data) async throws -> T {
    try JSONDecoder().decode(T.self, from: input)
  }
}
```

### Composition
Now we can compose these transactions using either the `pipe(into:)` method or the `Pipe` result builder:

```swift
struct Model: Decodable {
  let id: UUID
  var counter: Int
}

// Fluent method
let fluentLoad = LoadFile().pipe(into: DecodeModel<Model>())

// DSL
let declarativeLoad = Pipe {
  LoadFile()
  DecodeModel<Model>()
}
```

And we can run either of these transactions by calling `run(on:)` like so:

```swift
let onDiskModelURL = URL.documentsDirectory.appending(component: "model.json")
let fluentlyLoaded: Model = fluentLoad.run(on: onDiskModelURL)
let declarativelyLoaded: Model = declarativeLoad.run(on: onDiskModelURL)
```

We could also define a transaction to load the `Model` from the network by hitting some API and combine that transaction with `DecodeModel` in the exact same way.

### Transformation
transactions can also be transformed using the `map(_:)` operator that you might have used on arrays. For example, if we just wanted the value of `counter` on our model above, we could do something like this:
```swift
let loadCount = Pipe {
  LoadFile()
  DecodeModel<Model>()
}
.map(\.counter)
```

## What's the Point?
To borrow another concept from Point Free, what's the point of writing your code this way? Why not just write functions imperatively like most people already do?

### Atomicity
Transactions work best when they are as small as possible. This makes them incredibly easy both to test and to understand. Anyone coming into a codebase written this way could look at the `LoadFile` transaction and immediately know
the entire breadth of its functionality. No side-effects, no hidden intricacies.

### Transformation
You can get an entirely new transaction from one that you've already written without losing the original transaction or the tests you've written for it. In the example code above, `LoadFile` and `DecodeModel` can both be fully covered by
unit tests. This means that any transaction you get from transforming either of them gets that unit test coverage for free and any tests you write for your new transaction simply compounds your coverage.

### Composition
Imperatively written functions are essentially already composing other functions, they simply do it by assigning the output of functions to variables and then referencing those variables later on. Shared code _can_ be extracted from imperative
functions and stored in extensions or helper types but the more code that gets extracted, the more things start to look like transactions but without the benefits of composition and transformation provided by this library.

### Reusability
The previous three points really highlight just how reusable you can make a transaction. Even if you're not using the exact transaction again, you could transform it to make a variant for your immediate needs or you could compose it with other transactions to make a more complex, higher-order transaction. Additionally, the more transactions you write, the more you're able to compose and transform existing transactions into new ones.

I'm not advocating ditching imperative programming entirely (everything in programming is a balance), but I do think that the benefits listed above are significant enough to at least consider this approach. You'll also most likely call transactions
from an imperatively written function so there is room for both approaches.

## Ideas for the future
- [ ] Early exits
  - It would be super useful to have some way to tell a higher-order transaction to exit without running any transactions that are further down the execution list (or cancel concurrently running transactions).
- [ ] Catching errors
  - The ability to handle errors in combination with early exits would make the `flatMap(_:)` operator actually useful. As of now I haven't actually found a use for it...

## Credits
The design of this library and the benefits I claim this approach provides both mirror that of the [`swift-parsing` library by Point Free](https://github.com/pointfreeco/swift-parsing). Much of the code was translated directly from
their work and this project wouldn't exist without them. I was specifically inspired to write this after watching their [Parsing series](https://www.pointfree.co/collections/parsing) and their
[Composable Architecture series](https://www.pointfree.co/collections/composable-architecture).
