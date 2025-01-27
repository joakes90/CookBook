//
//  RecipeModel.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import Foundation

struct Recipe: Codable {
    let cuisine: String // The cuisine of the recipe.
    let name: String // The name of the recipe
    let largePhotoURL: URL? // The URL of the recipes’s full-size photo.
    let smallPhotoURL: URL? // The URL of the recipes’s small photo. Useful for list view.
    let uuid: String // The unique identifier for the receipe. Represented as a UUID.
    let sourceURL: URL? // The URL of the recipe's original website.
    let youtubeURL: URL? // The URL of the recipe's YouTube video.
    
    private enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case largePhotoURL = "photo_url_large"
        case smallPhotoURL = "photo_url_small"
        case uuid
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipesList: Codable {
    let recipes: [Recipe]
}
