//
//  AccountButton.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/10/24.
//

import SwiftUI

struct AccountButton<Background: ShapeStyle>: View {
    
    let text: String
    let symbol: String
    let textColor: Color
    let background: Background
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 330, height: 45)
                .foregroundStyle(background)
            
            Label(text, systemImage: symbol)
                .font(.system(size: 18))
                .foregroundStyle(textColor)
        }
    }
}

