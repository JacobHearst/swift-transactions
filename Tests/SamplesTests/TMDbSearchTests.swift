//
// TMDbSearchTests.swift
//

import Foundation
@testable import Samples
import TMDb
import XCTest

final class TMDbSearchTests: XCTestCase {
    override func setUp() {
        Current.tmdb = .mock
    }

    override func tearDown() {
        Current.tmdb = .live
    }

    func testSearchPeople() async throws {
        // Given
        var searchedQuery: String?
        let mockPerson = Person(id: 1, name: "Person", gender: .male)
        Current.tmdb.searchPeople = { query in
            searchedQuery = query
            return .init(results: [mockPerson])
        }

        let mockQuery = "Keanu Reeves"

        // When
        let results = try await SearchPeople().run(on: mockQuery)

        // Then
        XCTAssertEqual(searchedQuery, mockQuery)
        XCTAssertEqual(results, .init(results: [mockPerson]))
    }

    func testSearchMovies() async throws {
        // Given
        let mockMovie = Movie(id: 1, title: "Movie")

        var searchedQuery: String?
        Current.tmdb.searchMovies = { query in
            searchedQuery = query
            return .init(results: [mockMovie])
        }

        let mockQuery = "John Wick"

        // When
        let results = try await SearchMovies().run(on: mockQuery)

        // Then
        XCTAssertEqual(searchedQuery, mockQuery)
        XCTAssertEqual(results, .init(results: [mockMovie]))
    }

    func testSearchTVSeries() async throws {
        // Given
        let mockTVSeries = TVSeries(id: 1, name: "TV")

        var searchedQuery: String?
        Current.tmdb.searchTV = { query in
            searchedQuery = query
            return .init(results: [mockTVSeries])
        }

        let mockQuery = "John Wick"

        // When
        let results = try await SearchTVSeries().run(on: mockQuery)

        // Then
        XCTAssertEqual(searchedQuery, mockQuery)
        XCTAssertEqual(results, .init(results: [mockTVSeries]))
    }

    func testSearchTMDb() async throws {
        // Given
        let mockMovie = Movie(id: 1, title: "Movie")
        let mockPerson = Person(id: 1, name: "Person", gender: .male)
        let mockTVSeries = TVSeries(id: 1, name: "TV")

        var peopleSearchQuery: String?
        var movieSearchQuery: String?
        var tvSearchQuery: String?
        Current.tmdb = TMDbAPI(
            searchPeople: { query in
                peopleSearchQuery = query
                return .init(results: [mockPerson])
            },
            searchMovies: { query in
                movieSearchQuery = query
                return .init(results: [mockMovie])
            },
            searchTV: { query in
                tvSearchQuery = query
                return .init(results: [mockTVSeries])
            }
        )

        let mockQuery = "John"

        // When
        let results = try await SearchTMDb().run(on: mockQuery)

        // Then
        XCTAssertEqual(peopleSearchQuery, mockQuery)
        XCTAssertEqual(movieSearchQuery, mockQuery)
        XCTAssertEqual(tvSearchQuery, mockQuery)
        XCTAssertEqual(results.0, [mockPerson])
        XCTAssertEqual(results.1, [mockMovie])
        XCTAssertEqual(results.2, [mockTVSeries])
    }
}

private extension TMDbAPI {
    static var mock = Self(
        searchPeople: { _ in
            throw UnexpectedCallError.searchPeople
        },
        searchMovies: { _ in
            throw UnexpectedCallError.searchMovies
        },
        searchTV: { _ in
            throw UnexpectedCallError.searchTV
        }
    )

    enum UnexpectedCallError: Error {
        case searchPeople
        case searchMovies
        case searchTV
    }
}
