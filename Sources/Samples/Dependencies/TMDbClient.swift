//
// TMDbAPI.swift
//

import Foundation
import TMDb

struct TMDbAPI {
    var searchPeople: (String) async throws -> PersonPageableList
    var searchMovies: (String) async throws -> MoviePageableList
    var searchTV: (String) async throws -> TVSeriesPageableList
}

extension TMDbAPI {
    static var live: Self {
        let client = TMDbClient(apiKey: "")

        return TMDbAPI(
            searchPeople: {
                try await client.search.searchPeople(query: $0, filter: nil, page: nil, language: nil)
            },
            searchMovies: {
                try await client.search.searchMovies(query: $0, filter: nil, page: nil, language: nil)
            },
            searchTV: {
                try await client.search.searchTVSeries(query: $0, filter: nil, page: nil, language: nil)
            }
        )
    }
}
