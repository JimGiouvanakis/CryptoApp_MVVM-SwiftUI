//
//  AppViewModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 3/12/24.
//

import Foundation
import SwiftUI


class AppViewModel {
    
    static let shared = AppViewModel()
    private init() { }
    
    @Published var userLogStatus: UserLogStatus = .loggedOut
    
    @Published var userDefaults = UserDefaults.standard
    
//    func userLoggedInGoogle() {
//        self.userLogStatus = .google
//    }
//    
//    func userLoggedIn() {
//        self.userLogStatus = .email
//    }
//    
//    func userLoggedOut() {
//        self.userLogStatus = .loggedOut
//    }
}
