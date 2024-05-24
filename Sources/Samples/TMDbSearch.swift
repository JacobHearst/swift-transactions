//
// TMDbSearch.swift
//

import Foundation
import Transactions
import TMDb

struct SearchPeople: Transaction {
    func run(on query: String) async throws -> PersonPageableList {
        try await Current.tmdb.searchPeople(query)
    }
}

struct SearchMovies: Transaction {
    func run(on query: String) async throws -> MoviePageableList {
        try await Current.tmdb.searchMovies(query)
    }
}

struct SearchTVSeries: Transaction {
    func run(on query: String) async throws -> TVSeriesPageableList {
        try await Current.tmdb.searchTV(query)
    }
}

struct SearchTMDb: Transaction {
    var body: AnyTransaction<String, ([Person], [Movie], [TVSeries])> {
        Concurrent {
            SearchPeople()
            SearchMovies()
            SearchTVSeries()
        }
        .map { ($0.results, $1.results, $2.results) }
        .eraseToAnyTransaction()
    }
}
