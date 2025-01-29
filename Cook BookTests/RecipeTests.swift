//
//  Cook_BookTests.swift
//  Cook BookTests
//
//  Created by Justin Oakes on 1/27/25.
//

import Testing
@testable import Cook_Book
import SwiftUICore

struct RecipeTests {
    @Test("Recipe decodes successfully from complete JSON")
    func testRecipeDecoding() throws {
        // Given
        let jsonString = """
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://example.com/large.jpg",
            "photo_url_small": "https://example.com/small.jpg",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "source_url": "https://example.com/recipe",
            "youtube_url": "https://youtube.com/watch?v=123"
        }
        """
        let jsonData = Data(jsonString.utf8)
        
        // When
        let recipe = try JSONDecoder().decode(Recipe.self, from: jsonData)
        
        // Then
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.largePhotoURL?.absoluteString == "https://example.com/large.jpg")
        #expect(recipe.smallPhotoURL?.absoluteString == "https://example.com/small.jpg")
        #expect(recipe.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(recipe.sourceURL?.absoluteString == "https://example.com/recipe")
        #expect(recipe.youtubeURL?.absoluteString == "https://youtube.com/watch?v=123")
    }
    
    @Test("Recipe decodes successfully with missing optional fields")
    func testRecipeDecodingWithMissingOptionals() throws {
        // Given
        let jsonString = """
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8"
        }
        """
        let jsonData = Data(jsonString.utf8)
        
        // When
        let recipe = try JSONDecoder().decode(Recipe.self, from: jsonData)
        
        // Then
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.largePhotoURL == nil)
        #expect(recipe.smallPhotoURL == nil)
        #expect(recipe.sourceURL == nil)
        #expect(recipe.youtubeURL == nil)
    }
}
