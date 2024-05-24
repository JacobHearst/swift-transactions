//
// Map.swift
//

import Foundation

extension Transaction {
    @inlinable
    public func map<NewOutput>(
        _ transform: @escaping (Output) -> NewOutput
    ) -> Transactions.Map<Self, NewOutput> {
        .init(upstream: self, transform: transform)
    }
}

extension Transactions {
    public struct Map<Upstream: Transaction, NewOutput>: Transaction {
        public let upstream: Upstream
        public let transform: (Upstream.Output) -> NewOutput

        @inlinable
        public init(upstream: Upstream, transform: @escaping (Upstream.Output) -> NewOutput) {
            self.upstream = upstream
            self.transform = transform
        }

        @inlinable
        @inline(__always)
        public func run(on input: Upstream.Input) async throws -> NewOutput {
            try await self.transform(self.upstream.run(on: input))
        }
    }
}
