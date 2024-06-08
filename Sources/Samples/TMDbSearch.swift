//
// TMDbSearch.swift
//

import Foundation
import Transactions
import TMDb

struct Search: Transaction {
    func run(on query: String) async throws -> MediaPageableList {
        try await Current.tmdb.search(query)
    }
}

struct GetDetails: Transaction {
    func run(on input: Media) async throws -> Media {
        switch input {
        case .movie(let movie):
            try await .movie(Current.tmdb.movieDetails(movie.id))
        case .tvSeries(let series):
            try await .tvSeries(Current.tmdb.tvDetails(series.id))
        case .person(let person):
            try await .person(Current.tmdb.personDetails(person.id))
        }
    }
}

struct SearchWithDetails: CompositeTransaction {
    var body: AnyTransaction<String, [Media]> {
        Pipe {
            Search().map(\.results)
            ForEach {
                GetDetails()
            }
        }
        .eraseToAnyTransaction()
    }
}
