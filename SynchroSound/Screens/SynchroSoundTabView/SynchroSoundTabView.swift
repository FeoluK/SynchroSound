//
//  ContentView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI
import Observation

struct SynchroSoundTabView: View {

    @StateObject var viewModel = TabBarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $viewModel.selectedTab) {
                SynchroSoundScanView()
                    .tag("scan")
                
                SynchroSoundTextView()
                    .tag("text")
                
                SynchroSoundAccountView()
                    .tag("account")
                
                SynchroSoundInfoView(selectedTab: $viewModel.selectedTab)
                    .tag("info")
            }
            
            CustomTabView(selectedTab: $viewModel.selectedTab)
            
        }
        
    }
    
}

#Preview {
    SynchroSoundTabView()
}
