//
//  ContentView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

struct SynchroSoundTabView: View {
    
    @State private var selectedTab = "info"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                SynchroSoundScanView()
                    .tag("scan")
                
                SynchroSoundTextView()
                    .tag("text")
                
                SynchroSoundAccountView()
                    .tag("account")
                
                SynchroSoundInfoView()
                    .tag("info")
            }
            
            CustomTabView(selectedTab: $selectedTab)
            
        }
        
    }
    
}

#Preview {
    SynchroSoundTabView()
}

struct CustomTabView: View {
    
    @Binding var selectedTab: String
    
    var body: some View {
        
        VStack{
            Divider()
                .background(.brandPurple1)
                .padding(15)
            
            HStack(spacing: 25) {
                ForEach((TabItems.allCases), id: \.self) { item in
                    Button {
                        selectedTab = item.rawValue
                    } label: {
                        SynchroSoundTabBarItem(symbol: item.symbol)
                    }
                    
                }
            }
        }
        
        
    }
}
