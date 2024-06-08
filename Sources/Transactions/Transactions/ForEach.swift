//
// ForEach.swift
//

import Foundation

public struct ForEach<Element, Body: Transaction>: Transaction where Body.Input == Element {
    let body: Body

    public init(@TransactionBuilder<Body.Input> _ body: () -> Body) {
        self.body = body()
    }

    public func run(on input: [Element]) async throws -> [Body.Output] {
        try await input.map(body.run)
    }
}

extension Array {
    func map<NewElement>(_ transform: (Element) async throws -> NewElement) async rethrows -> [NewElement] {
        var result = [NewElement]()

        for element in self {
            try await result.append(transform(element))
        }

        return result
    }
}
