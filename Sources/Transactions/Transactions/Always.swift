//
// Always.swift
//

import Foundation

public struct Always<Upstream: Transaction, Output: Sendable>: Transaction {
    let output: Output

    public init(output: Output) {
        self.output = output
    }

    public func run(on input: Upstream.Input) async throws -> Output {
        output
    }
}
