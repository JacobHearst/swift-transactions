//
// OnDiskResources.swift
//

import Foundation
import Transactions

public struct Model: Codable, Equatable {
    public var label: String
    public var counter: Int
    public var isValid: Bool

    public init(label: String, counter: Int, isValid: Bool) {
        self.label = label
        self.counter = counter
        self.isValid = isValid
    }
}

public struct LoadData: Transaction {
    public init() {}
    public func run(on input: URL) async throws -> Data {
        try Current.data(input)
    }
}

public struct DecodeModel<T: Decodable>: Transaction {
    public init() {}
    public func run(on input: Data) async throws -> T {
        try JSONDecoder().decode(T.self, from: input)
    }
}

public struct IncrementModel: Transaction {
    public init() {}
    public func run(on input: Model) async throws -> Model {
        var copy = input
        copy.counter += 1
        return copy
    }
}
