//
//  SynchroSoundBackground.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

struct SynchroSoundBackground: View {
    var body: some View {
        LinearGradient(colors: [.brandLightBlue, .brandCyan, .brandBlue, .brandPurple3],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

#Preview {
    SynchroSoundBackground()
}
