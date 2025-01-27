//
//  RecipesViewModel.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    
    private let networkController = NetworkController.shared
    
    init() {
        Task {
            await fetchRecipes()
        }
    }
    
    @MainActor
    func fetchRecipes() async {
        do {
            recipes = try await networkController.fetchRecipes()
            print(recipes)
        } catch {
            print(error.localizedDescription)
            // TODO: Handle errors with alert
        }
    }
    
}
