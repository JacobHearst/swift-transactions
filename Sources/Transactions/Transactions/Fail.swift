//
// Fail.swift
//

import Foundation

public struct Fail<Upstream: Transaction>: Transaction {
    let reason: String?

    public init(reason: String?) {
        self.reason = reason
    }

    public func run(on input: Upstream.Input) async throws -> Upstream.Output {
        throw Failure(errorDescription: reason)
    }

    public struct Failure: LocalizedError {
        public var errorDescription: String?

        init(errorDescription: String? = nil) {
            self.errorDescription = errorDescription
        }
    }
}
