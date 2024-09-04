//
//  SynchroSoundInfoButton.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

struct SynchroSoundInfoCircle: View {
    let symbol: String
    let description: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(RadialGradient(colors: [.brandLightBlue, .cyan, .teal, .brandViolet, .brandPurple1],
                                         center: .top,
                                         startRadius: 20,
                                         endRadius: 150))
                    .frame(width: 135, height: 135)
                Image(systemName: symbol)
                    .font(.system(size: 85))
                    .foregroundStyle(.white)
            }
            
            Text(description)
                .font(.system(size: 19, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, description.isEmpty ? 0 : 2)
        }
    }
}


#Preview {
    SynchroSoundInfoCircle(symbol: "music.note", description: "This is the description.")
}
