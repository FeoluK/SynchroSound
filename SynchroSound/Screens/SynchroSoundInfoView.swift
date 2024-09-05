//
//  SynchroSoundInfoView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

struct SynchroSoundInfoView: View {
    
    @Binding var selectedTab: String
    
    var body: some View {
        ZStack {
            SynchroSoundBackground()
            
            VStack {
                SynchroSoundTitle()
                
                HStack(spacing: 20) {
                    SynchroSoundSymbolCircle(symbol: "music.note", description: "DESCRIBE \nYOUR FEELINGS")
                    
                    Image(systemName: "waveform.circle.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                        .offset(CGSize(width: 0, height: -18.0))
                    
                    SynchroSoundSymbolCircle(symbol: "music.note", description: "SCAN \nYOUR FACE")
                }
                
                HStack(spacing: 175) {
                    Image(systemName: "keyboard")
                        .font(.system(size: 45))
                        .foregroundStyle(.white)
                    
                    
                    Image(systemName: "faceid")
                        .font(.system(size: 45))
                        .foregroundStyle(.white)
                    
                }
                .padding(.bottom, 20)
                
                Divider()
                    .background(.white)
                    .padding(.horizontal, 20)
                
                Text("FIND YOUR BEST SONG MATCH")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, design: .rounded))
                
                Divider()
                    .background(.white)
                    .padding(.horizontal, 35)
                
                SynchroSoundSymbolCircle(symbol: "beats.headphones", description: "")
                
                Button {
                    selectedTab = "scan"
                } label: {
                    SynchroSoundInfoViewRoundBlock(text: "Begin")
                }
                
                Spacer()
                
            }
            
        }
        
    }
}

#Preview {
    SynchroSoundInfoView(selectedTab: .constant("info"))
}


