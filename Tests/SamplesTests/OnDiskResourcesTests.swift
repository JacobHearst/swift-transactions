//
// OnDiskResourcesTests.swift
//

import XCTest
@testable import Samples

final class OnDiskResourcesTests: XCTestCase {
    func testLoadData() async throws {
        // Given
        let mockContents = "test"
        var loadedURL: URL?
        Current.data = { url in
            loadedURL = url
            return Data(mockContents.utf8)
        }

        // When
        let output = try await LoadData().run(on: .mock)

        // Then
        XCTAssertEqual(loadedURL, .mock)
        XCTAssertEqual(String(data: output, encoding: .utf8), mockContents)
    }

    func testLoadDataWithError() async throws {
        // Given
        var loadedURL: URL?
        struct LoadError: Error { }
        Current.data = { url in
            loadedURL = url
            throw LoadError()
        }

        do {
            // When
            _ = try await LoadData().run(on: .mock)
            XCTFail("LoadData should have thrown an error")
        } catch _ as LoadError {
            // Then
            XCTAssertEqual(loadedURL, .mock)
        }
    }

    func testDecodeModel() async throws {
        // Given
        let mockData = try JSONEncoder().encode(Model.mock)

        // When
        let output = try await DecodeModel<Model>().run(on: mockData)

        // Then
        XCTAssertEqual(output, .mock)
    }

    func testDecodeModelWithError() async throws {
        // Given
        struct SomeOtherModel: Encodable {}
        let mockModel = SomeOtherModel()
        let mockData = try JSONEncoder().encode(mockModel)

        // When
        do {
            _ = try await DecodeModel<Model>().run(on: mockData)
            XCTFail("Transaction should have failed to decode the model")
        } catch {
            // noop
        }
    }

    func testIncrementModel() async throws {
        // When
        let output = try await IncrementModel().run(on: .mock)

        // Then
        XCTAssertEqual(output.counter, Model.mock.counter + 1)
    }
}

extension URL {
    static let mock = URL(fileURLWithPath: "someDir/someFile.someExtension")
}

extension Model {
    static let mock = Model(label: "test", counter: 1, isValid: false)
}
