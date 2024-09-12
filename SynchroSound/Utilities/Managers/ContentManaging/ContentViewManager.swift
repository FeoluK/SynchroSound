//
//  ContentViewManager.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/12/24.
//

import SwiftUI

struct ContentViewManager: View {
    @EnvironmentObject var loginState: LoginState
    
    var body: some View {
        if loginState.isLoggedIn {
            SynchroSoundTabView()
                .environmentObject(loginState)
        } else {
            SynchroSoundLoginView()
                .environmentObject(loginState)
        }
    }
}

#Preview {
    ContentViewManager()
        .environmentObject(LoginState())
}
