//
// AnyTransaction.swift
//

import Foundation

extension Transaction {
    public func eraseToAnyTransaction() -> AnyTransaction<Input, Output> {
        .init(self)
    }
}

public struct AnyTransaction<Input, Output>: Transaction {
    @usableFromInline
    let runner: @Sendable (Input) async throws -> Output

    @inlinable
    public init<T: Transaction>(_ transaction: T) where T.Input == Input, T.Output == Output {
        self.init(transaction.run)
    }

    @inlinable
    public init(_ run: @Sendable @escaping (Input) async throws -> Output) {
        self.runner = run
    }

    @inlinable
    public func run(on input: Input) async throws -> Output {
        try await self.runner(input)
    }

    @inlinable
    public func eraseToAnyTransaction() -> Self {
        self
    }
}
