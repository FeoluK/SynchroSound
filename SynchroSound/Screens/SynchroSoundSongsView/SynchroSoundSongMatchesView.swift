//
//  SynchroSoundSongMatchesView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/6/24.
//

import SwiftUI

struct SynchroSoundSongMatchesView: View {
    
    @StateObject var viewModel = SynchroSoundSongMatchesViewModel()
    
    var body: some View {
        
        VStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 10) {
                    ForEach(0..<10, id: \.self) { _ in
                        SpotifySongCell(name: "Jerusalema")
            
                    }
                }
                .padding(.horizontal)
                .padding(.top, 15)
            }
            .frame(maxHeight: 375)
        }
        .padding(.top, 15)
        .padding(.bottom, 40)
    }
}

#Preview {
    SynchroSoundSongMatchesView()
}
