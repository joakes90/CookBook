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
    @Published var error: Error?
    
    @MainActor
    private let networkController = NetworkController.shared
    
    init() {
        Task {
            await fetchRecipes()
        }
    }
    
    @MainActor
    func fetchRecipes() async {
        recipes.removeAll()
        isLoading = true
        do {
            recipes = try await networkController.fetchRecipes()
            error = nil
        } catch {
            recipes = []
            self.error = error
        }
        isLoading = false
    }
    
}
