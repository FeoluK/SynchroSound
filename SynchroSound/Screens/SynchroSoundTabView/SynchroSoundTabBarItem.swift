//
//  SynchroSoundTabBarItem.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

struct SynchroSoundTabBarItem: View {
    let symbol: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.brandCyan)
                .frame(width: 60, height: 60)
            
            Image(systemName: symbol)
                .tint(.brandLightBlue)
                .font(.system(size: 35))
        }
        
    }
}

#Preview {
    SynchroSoundTabBarItem(symbol: "questionmark")
}
