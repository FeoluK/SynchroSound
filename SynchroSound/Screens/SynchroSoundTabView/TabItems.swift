//
//  TabItems.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import Foundation

enum TabItems: String, CaseIterable {
    case scan = "scan"
    case account = "account"
    case info = "info"
    
    
    var symbol: String {
        switch self {
        case .scan:
            return "faceid"
        case .account:
            return "gear"
        case .info:
            return "questionmark"
        }
    }
}
