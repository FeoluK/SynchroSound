//
//  SynchroSoundSongBackground.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SynchroSoundSongBackground: View {
    var body: some View {
        LinearGradient(colors: [.brandCyan, .brandBlue, .brandPurple3],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

#Preview {
    SynchroSoundSongBackground()
}
