//
//  NetworkController.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import Foundation
import SwiftData
import UIKit

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

@MainActor
class NetworkController {
    static let shared = NetworkController()
    private let imageCache = NSCache<NSURL, NSData>()
    private let modelContainer = try? ModelContainer(for: ImageCache.self)
    
    private var modelContext: ModelContext? {
        modelContainer?.mainContext
    }
    
    private init() {}
    
    func fetchRecipes() async throws -> [Recipe] {
        let url = RecipeURL.recipe.urlValue
//        let url = RecipeURL.empty.urlValue
//        let url = RecipeURL.malformed.urlValue
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(RecipesList.self, from: data)
        return recipes.recipes
    }
    
    func cachedImageForURL(_ url: URL) -> Data? {
        if let cachedData = imageCache.object(forKey: url as NSURL) {
            return Data(referencing: cachedData)
        }
        
        let descriptor = FetchDescriptor<ImageCache>(predicate: #Predicate { $0.url == url })
        if let cachedImage = try? modelContext?.fetch(descriptor).first {
            imageCache.setObject(cachedImage.data as NSData, forKey: url as NSURL)
            return cachedImage.data
        }
        
        return UIImage(systemName: "photo")?.pngData()
    }
    
    func fetchImage(for url: URL) async -> Data? {
        if let cachedData = cachedImageForURL(url) {
            return cachedData
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            imageCache.setObject(data as NSData, forKey: url as NSURL)
            
            let newCache = ImageCache(url: url, data: data)
            modelContext?.insert(newCache)
            try modelContext?.save()
            
            return data
        } catch {
#if DEBUG
            print("Error fetching image: \(error)")
#endif
            return UIImage(systemName: "photo")?.pngData()
        }
    }
}
