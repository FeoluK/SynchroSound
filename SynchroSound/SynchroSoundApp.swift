//
//  SynchroSoundApp.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

@main
struct SynchroSoundApp: App {
    @StateObject private var loginState = LoginState()

    var body: some Scene {
        WindowGroup {
            ContentViewManager()
                .environmentObject(loginState)
        }
        .modelContainer(for: [User.self])
    }
}

