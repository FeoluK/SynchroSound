//
//  SynchroSoundTabView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI
import Observation

struct SynchroSoundTabView: View {

    @StateObject var viewModel = TabBarViewModel()
    @State private var showTabView = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $viewModel.selectedTab) {
                SynchroSoundScanView()
                    .tag("scan")
                
                SynchroSoundAccountView(showTabView: $showTabView)
                    .tag("account")
                
                SynchroSoundInfoView(selectedTab: $viewModel.selectedTab)
                    .tag("info")
            }
            
            if showTabView {
                CustomTabView(selectedTab: $viewModel.selectedTab)
            }
            
        }
        .ignoresSafeArea(.keyboard)
        
    }
    
}

#Preview {
    SynchroSoundTabView()
        .environmentObject(LoginState())
}
