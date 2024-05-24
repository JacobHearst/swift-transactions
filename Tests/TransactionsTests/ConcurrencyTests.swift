//
// ConcurrencyTests.swift
//

import Transactions
import XCTest

final class ConcurrencyTests: XCTestCase {
    func testConcurrentTransactionTiming() async throws {
        let transaction = Concurrent {
            Delay(.seconds(0.4))
            Delay(.seconds(0.3))
            Delay(.seconds(0.2))
            Delay(.seconds(0.1))
            Delay(.seconds(0))
        }
        .map { (
            slower: Delay.Output,
            slow: Delay.Output,
            medium: Delay.Output,
            fast: Delay.Output,
            faster: Delay.Output
        ) -> [Delay.Output] in
            [faster, fast, medium, slow, slower]
        }

        let results = try await transaction.run()
        let sortedByCompletedAt = results.sorted { lhs, rhs in
            lhs.1 < rhs.1
        }

        for (idx, result) in results.enumerated() {
            let sortedAtResult = sortedByCompletedAt[idx]
            XCTAssertEqual(result.0, sortedAtResult.0)
            XCTAssertEqual(result.1, sortedAtResult.1)
        }
    }

    struct Delay: Transaction {
        typealias Output = (Duration, Date)

        let duration: Duration
        init(_ duration: Duration) {
            self.duration = duration
        }

        func run(on: Void) async throws -> Output {
            try await Task.sleep(for: duration)
            return (duration, Date())
        }
    }
}
