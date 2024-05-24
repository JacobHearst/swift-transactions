//
// PipeBuilder.swift
//

import Foundation

public struct Pipe<Input, Transactions: Transaction>: Transaction where Transactions.Input == Input {
    public let transactions: Transactions

    public init(
        input inputType: Input.Type = Input.self,
        @PipeBuilder<Input> body: () -> Transactions
    ) {
        self.transactions = body()
    }

    public func run(on input: Transactions.Input) async throws -> Transactions.Output {
        try await transactions.run(on: input)
    }
}

@resultBuilder
public enum PipeBuilder<Input> {
    @inlinable
    public static func buildPartialBlock<T: Transaction>(first: T) -> T where T.Input == Input {
        first
    }

    @inlinable
    public static func buildPartialBlock<T0, T1>(accumulated: T0, next: T1) -> Transactions.Pipe<T0, T1>
    where T0.Input == Input, T1.Input == T0.Output {
        .init(accumulated, next)
    }
}
