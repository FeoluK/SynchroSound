//
//  SynchroSoundSongsView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SynchroSoundSongsView: View {
    
    @ObservedObject var viewModel: SynchroSoundScanViewModel
    
    var body: some View {
        ZStack {
            SynchroSoundSongBackground()
            
            VStack(spacing: 0) {
                
                Circle()
                    .frame(width: 250, height: 250)
                    .foregroundStyle(.white)
                
                Text("Your Song Matches")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                Text("Songs based on your current mood")
                    .font(.system(size: 23, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 350, height: 5)
                    .foregroundStyle(.brandVibrantBlue)
                    .padding(.vertical, 15)
                
                HStack(spacing: 35) {
                    SynchroSoundInfoViewRoundBlock(text: "Save")
                    SynchroSoundInfoViewRoundBlock(text: "Mood")
                }
                
                SynchroSoundSongMatchesView()
            }
            
            
            VStack() {
                HStack {
                    Button {
                        viewModel.showEmotionResults = false
                    } label: {
                        XDismissButton()
                            .offset(CGSize(width: 0, height: -20.0))
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}
