//
//  SynchroSoundScanLoadingView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

struct SynchroSoundScanLoadingView: View {
    var body: some View {
        ZStack {
            SynchroSoundBackground()
            
            VStack {
                Text("SCANNING FACE \nAND \nGATHERING SONGS")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .offset(CGSize(width: 0, height: -50))
                    
                
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2.5)
                    .padding(.top, 50)
                    .offset(CGSize(width: 0, height: -50))
            }
                
        }
    }
}

#Preview {
    SynchroSoundScanLoadingView()
}
