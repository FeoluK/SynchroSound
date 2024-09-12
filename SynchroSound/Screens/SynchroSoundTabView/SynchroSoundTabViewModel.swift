//
//  SynchroSoundTabViewModel.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var selectedTab: String = "info"
}


struct CustomTabView: View {
 
    @Binding var selectedTab: String

    static let height: CGFloat = 60

    var body: some View {
        VStack {
            Divider()
                .background(.white)
                .frame(width: 360)
                .padding(.bottom, 15)
            
            HStack(spacing: 25) {
                ForEach(TabItems.allCases, id: \.self) { item in
                    Button {
                        selectedTab = item.rawValue
                    } label: {
                        SynchroSoundTabBarItem(symbol: item.symbol)
                    }
                    
                }
            }
        }
        .frame(height: Self.height)
    }
}
