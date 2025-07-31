//
//  Enums.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 3/12/24.
//

import Foundation

enum NetworkError: Error {
    case generalError
    case invalidUrl
    case invalidResponse
    case noData
    case degodingError
}

enum TabBarSelection {
    case home
    case search
    case favorites
    case settings
}

enum UserLogStatus {
    case email
    case google
    case loggedOut
}

enum GoogleAuthenticationError: Error {
    case runtimeError(String)
}
