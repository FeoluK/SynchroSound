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
                
                VStack(spacing: 0) {
                    Text("Sync Your Mood with Music")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("SynchroSound analyzes your facial expressions to match your mood with the perfect song.")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    
                    
                    Text("Just scan your face to get started, and let us sync your emotions with music tailored just for you!")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        
                }
                
                HStack(spacing: 20) {
                    SynchroSoundSymbolCircle(symbol: "faceid", description: "SCAN")
                }
                
                Divider()
                    .background(.white)
                    .padding(.horizontal, 20)
                
                Text("Let the Music Match Your Mood")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, design: .rounded))
                    .padding(.vertical, 10)
                
                Divider()
                    .background(.white)
                    .padding(.horizontal, 35)
                
                Button {
                    selectedTab = "scan"
                } label: {
                    SynchroSoundInfoViewRoundBlock(text: "Try It!")
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SynchroSoundInfoView(selectedTab: .constant("info"))
}
