//
//  SynchroSoundGenreSelectionCell.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/10/24.
//

import SwiftUI

struct SynchroSoundGenreSelectionCell: View {
    
    @ObservedObject var viewModel: SynchroSoundAccountViewModel
    @State var isSelected = false
    let genre: String
    
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 110, height: 40)
                .foregroundStyle(.gray)
            
            HStack() {
                Button {
                    if isSelected {
                        isSelected.toggle()
                        viewModel.numSelectedGenres -= 1
                    } else {
                        if viewModel.numSelectedGenres < 5 {
                            isSelected.toggle()
                            viewModel.numSelectedGenres += 1
                        } else {
                            viewModel.showingMaxSelectionAlert.toggle()
                        }
                    }
                    
                } label: {
                    Image(systemName: isSelected ? "checkmark.square.fill" : "checkmark.square")
                        .foregroundStyle(.white)
                        .font(.system(size: 25))
                }
                
                Text(genre.capitalized)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(width: 60)
                
            }
        }
    }
}

#Preview {
    SynchroSoundGenreSelectionCell(viewModel: SynchroSoundAccountViewModel(), genre: "r-n-b")
}
