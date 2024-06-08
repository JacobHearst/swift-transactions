//
// Transaction.swift
//

import Foundation

// MARK: Transaction
public protocol Transaction: Sendable {
    associatedtype Input: Sendable
    associatedtype Output: Sendable

    @Sendable
    @inlinable
    func run(on input: Input) async throws -> Output
}

// MARK: Bodies
public protocol TransactionBody: Transaction {
    associatedtype _Body
    typealias Body = _Body

    @TransactionBuilder<Input>
    var body: Body { get }
}

extension TransactionBody where Body: Transaction, Body.Input == Input, Body.Output == Output {
    @inlinable
    public func run(on input: Body.Input) async throws -> Body.Output {
        try await self.body.run(on: input)
    }
}

// MARK: callAsFunction and convenience overloads
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
