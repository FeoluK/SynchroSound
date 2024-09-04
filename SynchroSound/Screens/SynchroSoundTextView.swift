//
//  SynchroSoundTextView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

struct SynchroSoundTextView: View {
    var body: some View {
        ZStack {
            SynchroSoundBackground()
            Text("This is the text input view")
        }
    }
}

#Preview {
    SynchroSoundTextView()
}
