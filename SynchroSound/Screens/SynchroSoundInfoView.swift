//
//  SynchroSoundInfoView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

struct SynchroSoundInfoView: View {
    @State var sheetPresented = false
    
    var body: some View {
        ZStack {
            SynchroSoundBackground()
            
            VStack {
                SynchroSoundTitle()
                
                HStack(spacing: 80) {
                    SynchroSoundInfoButton(symbol: "music.note")
                    SynchroSoundInfoButton(symbol: "music.note")
                }
                
                Spacer()

            }
                        
        }
        
    }
}

#Preview {
    SynchroSoundInfoView()
}


