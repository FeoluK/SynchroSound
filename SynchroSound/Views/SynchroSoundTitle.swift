//
//  SynchroSoundTitle.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

struct SynchroSoundTitle: View {
    var body: some View {
        VStack {
            Text("SynchroSound")
                .font(.system(size: 52, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
            Text("TUNE INTO YOUR EMOTIONS")
                .font(.system(size: 25, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SynchroSoundTitle()
}
