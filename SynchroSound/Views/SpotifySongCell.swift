//
//  SpotifySongCell.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SpotifySongCell: View {
    let name: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .frame(width: 175, height: 175)
                .foregroundStyle(.brandCyan)
            
            Text(name)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .lineLimit(2)
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .frame(maxWidth: 160, maxHeight: 160, alignment: .bottomLeading)
                
            
            
        }
    }
}

#Preview {
    SpotifySongCell(name: "Jerusalemaaaaaaaaaaaaaaa")
}
