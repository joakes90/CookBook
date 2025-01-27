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
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                    Text("Loading...")
                } else {
                    if viewModel.recipes.isEmpty {
                        Text("No Recipes Found")
                            .font(.headline)
                    } else {
                        Text("Hello World")
                    }
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipesView()
}
