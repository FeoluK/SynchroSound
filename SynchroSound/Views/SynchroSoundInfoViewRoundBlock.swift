//
//  SynchroSoundInfoViewButton.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

struct SynchroSoundInfoViewRoundBlock: View {
    let text: String
    
    var body: some View {
        Text(text)
            .frame(width: 140, height: 50)
            .font(.system(size: 28, weight: .medium, design: .rounded))
            .background(.brandLightBlue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    SynchroSoundInfoViewRoundBlock(text: "Text")
}
