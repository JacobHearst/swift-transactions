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

    // Assert that the `Search` transaction _only_ performs search (and doesn't get details)
    func testSearch() async throws {
        // Given
        let mockResults: [Media]  = [
            .movie(Movie(id: 1, title: "Movie")),
            .tvSeries(TVSeries(id: 1, name: "TV")),
            .person(Person(id: 1, name: "Person", gender: .male)),
        ]

        var searchQuery: String?
        Current.tmdb.search = { query in
            searchQuery = query
            return .init(results: mockResults)
        }

        let mockQuery = "John"

        // When
        let results = try await Search().run(on: mockQuery)

        // Then
        XCTAssertEqual(searchQuery, mockQuery)
        XCTAssertEqual(results.results, mockResults)
    }

    // Assert that the `SearchWithDetails` transaction properly pipes the search results into the `ForEach` and nested `GetDetails`
    func testSearchWithDetails() async throws {
        // Given
        let mockMovie = Movie(id: 1, title: "Movie")
        let mockSeries = TVSeries(id: 1, name: "TV")
        let mockPerson = Person(id: 1, name: "Person", gender: .male)

        let mockDetailedMovie = Movie(id: mockMovie.id, title: mockMovie.title, imdbID: "someMovie")
        let mockDetailedSeries = TVSeries(id: mockSeries.id, name: mockSeries.name, numberOfEpisodes: 10)
        let mockDetailedPerson = Person(id: mockPerson.id, name: mockPerson.name, gender: mockPerson.gender, imdbID: "somePerson")

        var searchQuery: String?
        var movieID: Movie.ID?
        var seriesID: TVSeries.ID?
        var personID: Person.ID?
        Current.tmdb = TMDbAPI(
            search: { query in
                searchQuery = query
                return .init(results: [.movie(mockMovie), .tvSeries(mockSeries), .person(mockPerson)])
            },
            movieDetails: { id in
                movieID = id
                return mockDetailedMovie
            },
            tvDetails: { id in
                seriesID = id
                return mockDetailedSeries
            },
            personDetails: { id in
                personID = id
                return mockDetailedPerson
            }
        )

        let mockQuery = "John"

        // When
        let results = try await SearchWithDetails().run(on: mockQuery)

        // Then
        XCTAssertEqual(searchQuery, mockQuery)
        XCTAssertEqual(movieID, mockMovie.id)
        XCTAssertEqual(seriesID, mockSeries.id)
        XCTAssertEqual(personID, mockPerson.id)
        XCTAssertEqual(results, [.movie(mockDetailedMovie), .tvSeries(mockDetailedSeries), .person(mockDetailedPerson)])
    }
}

private extension TMDbAPI {
    static var mock = Self(
        search: { _ in throw UnexpectedCallError.search },
        movieDetails: { _ in throw UnexpectedCallError.movieDetails },
        tvDetails: { _ in throw UnexpectedCallError.tvDetails },
        personDetails: { _ in throw UnexpectedCallError.personDetails }
    )

    enum UnexpectedCallError: Error {
        case search
        case movieDetails
        case tvDetails
        case personDetails
    }
}
