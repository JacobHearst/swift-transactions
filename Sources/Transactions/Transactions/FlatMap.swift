//
// FlatMap.swift
//

import Foundation

extension Transaction {
    @inlinable
    public func flatMap<NewTransaction: Transaction>(
        transform: @escaping (Output) -> NewTransaction
    ) -> Transactions.FlatMap<NewTransaction, Self> {
        .init(upstream: self, transform: transform)
    }
}

extension Transactions {
    public struct FlatMap<NewTransaction: Transaction, Upstream: Transaction>: Transaction where NewTransaction.Input == Upstream.Input {

        public let upstream: Upstream
        public let transform: (Upstream.Output) async throws -> NewTransaction

        @inlinable
        public init(upstream: Upstream, transform: @escaping (Upstream.Output) async throws -> NewTransaction) {
            self.upstream = upstream
            self.transform = transform
        }

        @inlinable
        public func run(on input: Upstream.Input) async throws -> NewTransaction.Output {
            return try await self.transform(self.upstream.run(on: input)).run(on: input)
        }
    }
}
