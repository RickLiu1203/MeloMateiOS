//
//  Track.swift
//  MeloMateiOS
//
//  Created by Rick Liu on 2024-10-14.
//

import Foundation

struct Track: Identifiable, Codable {
    var id: String
    var name: String
    var artist: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist = "artists" // Assuming this field might come from Spotify API
    }
}
