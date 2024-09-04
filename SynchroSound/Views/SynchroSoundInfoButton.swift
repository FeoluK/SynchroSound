//
//  SynchroSoundInfoButton.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

struct SynchroSoundInfoButton: View {
    @State var sheetPresented = false
    let symbol: String
    
    var body: some View {
        Button {
            sheetPresented = true
        } label: {
            ZStack {
                Circle()
                    .fill(RadialGradient(colors: [.brandLightBlue, .cyan, .teal, .brandViolet, .brandPurple1],
                                         center: .top,
                                         startRadius: 20,
                                         endRadius: 150))
                    .frame(width: 120, height: 120)
                Image(systemName: symbol)
                    .font(.system(size: 85))
                    .foregroundStyle(.white)
            }
        }
    }
}


#Preview {
    SynchroSoundInfoButton(symbol: "music.note")
}
