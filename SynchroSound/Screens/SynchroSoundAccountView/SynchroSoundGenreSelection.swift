//
//  SynchroSoundGenreSelection.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/10/24.
//

import SwiftUI

import SwiftUI

struct SynchroSoundGenreSelection: View {
    
    @ObservedObject var viewModel: SynchroSoundAccountViewModel
        
    var body: some View {
        VStack {
            TextField("Search genres", text: $viewModel.searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 10) {
                    ForEach(viewModel.filteredGenres, id: \.self) { genre in
                        SynchroSoundGenreSelectionCell(viewModel: viewModel, genre: genre)
                    }
                }
            }
            .onAppear() {
                viewModel.getGenres()
            }
        }
    }
}

#Preview {
    SynchroSoundGenreSelection(viewModel: SynchroSoundAccountViewModel())
}
