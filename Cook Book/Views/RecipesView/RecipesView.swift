//
//  RecipesView.swift
//  Cook Book
//
//  Created by Justin Oakes on 1/27/25.
//

import SwiftUI

struct RecipesView: View {
    @ObservedObject var viewModel: RecipesViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading && viewModel.recipes.isEmpty {
                    VStack {
                        ProgressView()
                            .padding()
                        Text("Loading...")
                            .foregroundColor(.gray)
                    }
                } else {
                    List(viewModel.recipes, id: \.uuid) { recipe in
                        RecipeItemView(recipe: recipe)
                    }
                    .refreshable {
                        await viewModel.fetchRecipes()
                    }
                    .overlay(Group {
                        if viewModel.recipes.isEmpty {
                            VStack {
                                Spacer()
                                Text("No Recipes Found")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    })
                }
            }
            .navigationTitle("Recipes")
            .alert("Error", isPresented: .init(
                get: { viewModel.error != nil },
                set: { if !$0 { viewModel.error = nil } }
            )) {
                Button("Retry") {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.error?.localizedDescription ?? "An unknown error occurred")
            }
        }
    }
}

#Preview {
    RecipesView()
}
