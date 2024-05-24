//
// BuilderTests.swift
//

import Transactions
import XCTest

final class BuilderTests: XCTestCase {
    func testPipeSuccess() async throws {
        // Given
        let input = "1234"
        let pipe = Pipe {
            StringCount()
            Square()
            AsNumbers()
        }

        // When
        let output = try await pipe.run(on: input)

        // Then
        XCTAssertEqual(output, "12345678910111213141516")
    }

    func testPipeFailure() async throws {
        // Given
        let input = "1234"
        let pipe = Pipe {
            StringCount()
            Square()
            Throw()
        }

        // When
        do {
            _ = try await pipe.run(on: input)
            XCTFail("Pipe should have thrown")
        } catch _ as Throw.SomeErr {
            // Then we got the expected behavior
        }
    }

    func testExecuteSuccess() async throws {
        // Given
        let input = 2
        let transaction = Execute {
            Square()
            AsNumbers()
        }

        // When
        let output = try await transaction.run(on: input)

        // Then
        XCTAssertEqual(output.0, 4)
        XCTAssertEqual(output.1, "12")
    }

    func testExecuteFailure() async throws {
        // Given
        let input = 2
        let transaction = Execute {
            Square()
            Throw()
        }

        // When
        do {
            _ = try await transaction.run(on: input)
            XCTFail("Pipe should have thrown")
        } catch _ as Throw.SomeErr {
            // Then we got the expected behavior
        }
    }

    struct StringCount: Transaction {
        func run(on input: String) async throws -> Int {
            input.count
        }
    }

    struct Square: Transaction {
        func run(on input: Int) async throws -> Int {
            input * input
        }
    }

    struct AsNumbers: Transaction {
        func run(on input: Int) async throws -> String {
            (1...input).map(String.init).joined()
        }
    }

    struct Throw: Transaction {
        struct SomeErr: Error {}

        func run(on input: Int) async throws -> Void {
            throw SomeErr()
        }
    }
}
