//
// World.swift
//

import Foundation

var Current = World()

struct World {
    var data: (URL) throws -> Data = { try Data(contentsOf: $0) }
    var tmdb: TMDbAPI = .live
}
