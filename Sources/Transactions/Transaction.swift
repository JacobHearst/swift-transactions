//
// Transaction.swift
//

import Foundation

public protocol Transaction {
    associatedtype Input: Sendable
    associatedtype Output: Sendable

    associatedtype _Body
    typealias Body = _Body

    @inlinable
    func run(on input: Input) async throws -> Output

    @TransactionBuilder<Input>
    var body: Body { get }
}

extension Transaction where Body == Never {
    /// A non-existent body.
    ///
    /// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
    @_transparent
    public var body: Body {
        fatalError(
      """
      '\(Self.self)' has no body. …

      Do not access a transaction's 'body' property directly, as it may not exist. To run a transaction, \
      call 'Transaction.run(on:)', instead.
      """
        )
    }
}

extension Transaction where Body: Transaction, Body.Input == Input, Body.Output == Output {
    @inlinable
    public func run(on input: Body.Input) async throws -> Body.Output {
        try await self.body.run(on: input)
    }
}

extension Transaction {
    @inlinable
    public func callAsFunction(input: Input) async throws -> Output {
        try await self.run(on: input)
    }
}

extension Transaction where Input == Void {
    @inlinable
    public func callAsFunction() async throws -> Output {
        return try await self.run(on: ())
    }

    @inlinable
    public func run() async throws -> Output {
        return try await self.run(on: ())
    }
}

extension Transaction where Output == Void {
    @inlinable
    public func callAsFunction(input: Input) async throws {
        _ = try await run(on: input)
    }

    @inlinable
    public func run(input: Input) async throws {
        _ = try await run(on: input)
    }
}

extension Transaction where Input == Void, Output == Void {
    @inlinable
    public func callAsFunction() async throws {
        _ = try await run(on: ())
    }

    @inlinable
    public func run() async throws {
        _ = try await run(on: ())
    }
}
