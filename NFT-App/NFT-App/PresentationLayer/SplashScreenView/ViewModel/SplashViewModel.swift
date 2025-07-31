//
//  SplashViewModel.swift
//  CryptoApp_MVVM-SwiftUI
//
//  Created by Dimitris Giouvanakis on 31/7/25.
//

import Foundation
import SwiftUI
import Observation
import FirebaseAuth


@MainActor
@Observable
final class SplashViewModel {

    var isActive = false
    var size = 0.6
    var opacity = 0.5
    var userToken : String?
    var uid : String?
    var isLoggedIn : Bool = false
    var oldUserToken: String?
    var olduid: String?
    
    
    func setup() async {
        oldUserToken = AppViewModel.shared.userDefaults.string(forKey: "Token")
        olduid = AppViewModel.shared.userDefaults.string(forKey: "uid")
        if oldUserToken != "" && olduid != "" {
            do {
                if let tokenResult = try await Auth.auth().currentUser?.getIDTokenResult() {
                    userToken = tokenResult.token
                    let user = Auth.auth().currentUser
                    uid = user?.uid
                    if userToken == oldUserToken && uid == olduid {
                        AppViewModel.shared.userLogStatus = .email
                        isLoggedIn = true
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
}
