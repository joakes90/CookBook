//
//  NetworkController.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import Foundation

enum RecipeURL: String {
    case recipe = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case malformed = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    case empty = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    var urlValue: URL {
        guard let url = URL(string: self.rawValue) else {
            fatalError("Invalid URL: \(self.rawValue)")
        }
        return url
    }
}

class NetworkController {
    static let shared = NetworkController()
    
    private init() {}
    
    func fetchRecipes() async throws -> [Recipe] {
        let url = RecipeURL.recipe.urlValue
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(RecipesList.self, from: data)
        return recipes.recipes
    }
}
