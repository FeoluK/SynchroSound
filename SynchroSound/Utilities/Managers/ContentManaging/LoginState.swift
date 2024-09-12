//
//  LoginState.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/12/24.
//

import SwiftUI

class LoginState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
}
