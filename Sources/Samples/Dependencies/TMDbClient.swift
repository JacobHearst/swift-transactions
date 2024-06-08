//
// TMDbAPI.swift
//

import Foundation
import TMDb

struct TMDbAPI {
    var search: (String) async throws -> MediaPageableList
    var movieDetails: (Movie.ID) async throws -> Movie
    var tvDetails: (TVSeries.ID) async throws -> TVSeries
    var personDetails: (Person.ID) async throws -> Person
}

extension TMDbAPI {
    static var live: Self {
        let client = TMDbClient(apiKey: "")

        return TMDbAPI(
            search: { try await client.search.searchAll(query: $0, filter: nil, page: nil, language: nil) },
            movieDetails: { try await client.movies.details(forMovie: $0, language: nil) },
            tvDetails: { try await client.tvSeries.details(forTVSeries: $0, language: nil) },
            personDetails: { try await client.people.details(forPerson: $0, language: nil) }
        )
    }
}
