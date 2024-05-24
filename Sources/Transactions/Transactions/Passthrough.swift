//
// Passthrough.swift
//

import Foundation

extension Transaction {
    public func passThrough<T: Transaction>(_ transaction: T) -> Transactions.Passthrough<T> where T.Input == Input, T.Output == Void {
        .init(transaction)
    }
}

extension Transactions {
    public struct Passthrough<T: Transaction>: Transaction where T.Output == Void {
        let transaction: T

        public init(_ transaction: T) {
            self.transaction = transaction
        }

        public func run(on input: T.Input) async throws -> T.Input {
            try await transaction.run(on: input)
            return input
        }
    }
}
