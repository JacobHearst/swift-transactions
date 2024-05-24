//
// Pipe.swift
//

import Foundation

extension Transaction {
    public func pipe<Downstream: Transaction>(
        into downstream: Downstream
    ) -> Transactions.Pipe<Self, Downstream> where Downstream.Input == Output {
        .init(self, downstream)
    }
}

extension Transactions {
    public struct Pipe<T0: Transaction, T1: Transaction>: Transaction where T0.Output == T1.Input {
        public let t0: T0
        public let t1: T1

        @inlinable
        public init(_ t0: T0, _ t1: T1) {
            self.t0 = t0
            self.t1 = t1
        }

        @inlinable
        public func run(on input: T0.Input) async throws -> T1.Output {
            try await t1.run(on: t0.run(on: input))
        }
    }
}
