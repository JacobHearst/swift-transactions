//
// Try.swift
//

import Foundation

public struct Try<T: Transaction, Catch: Transaction>: Transaction where Catch.Input == Error, Catch.Output == Void {
    let trying: T
    let handler: Catch

    public init(@TransactionBuilder<T.Input> _ trying: () -> T, @TransactionBuilder<Error> onError: () -> Catch) {
        self.trying = trying()
        self.handler = onError()
    }

    public func run(on input: T.Input) async throws -> T.Output? {
        do {
            return try await trying.run(on: input)
        } catch {
            try await handler.run(on: error)
            return nil
        }
    }
}

public struct TryWithFallback<Upstream: Transaction>: Transaction {
    let upstream: Upstream
    let defaultOutput: Upstream.Output

    public init(@TransactionBuilder<Upstream.Input> _ upstream: () -> Upstream, defaultOutput: Upstream.Output) {
        self.upstream = upstream()
        self.defaultOutput = defaultOutput
    }

    public func run(on input: Upstream.Input) async throws -> Upstream.Output {
        (try? await upstream.run(on: input)) ?? defaultOutput
    }
}
