//
//  RecipeItemView.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import SwiftUI

struct RecipeItemView: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if let imageData = recipe.cachedSmallPhoto {
                Image(uiImage: UIImage(data: imageData)!)
            } else {
                ProgressView()
                    .task {
                        guard let url = recipe.smallPhotoURL else { return }
                        await NetworkController.shared.fetchImageImage(for: url)
                    }
            }
                
            VStackLayout(alignment: .leading) {
                Text(recipe.name)
                Text(recipe.cuisine)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    let recipeJSONString = """
{
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        }
"""
    let recipeData = Data(recipeJSONString.utf8)
    let recipe = try! JSONDecoder().decode(Recipe.self, from: recipeData)
    RecipeItemView(recipe: recipe)
}
