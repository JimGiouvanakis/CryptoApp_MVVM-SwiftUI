//
//  LoginViewModel.swift
//  CryptoApp_MVVM-SwiftUI
//
//  Created by Dimitris Giouvanakis on 31/7/25.
//

import Foundation
import Observation
import FirebaseAuth
import SwiftUI

@MainActor
@Observable
final class LoginViewModel {
    
    var emailTextFieldText: String = ""
    var passwordTextFieldText: String = ""
    var showPopUp: Bool = false
    var popUpText: String = ""
    var popUpHeadText: String = ""
    var isEroor: Bool = false
    
    var path = NavigationPath()
    
    var goToLobby:Bool = false
    var goToCreate:Bool = false
    
    func singInUser() async {
        do {
            try await  AuthenticationManager.shared.singInUser(email: emailTextFieldText, password: passwordTextFieldText)
            let tokenResult = try await Auth.auth().currentUser?.getIDTokenResult()
            let userToken = tokenResult?.token
            let user = Auth.auth().currentUser
            let uid = user?.uid
            AppViewModel.shared.userDefaults.set(userToken, forKey: "Token")
            AppViewModel.shared.userDefaults.set(uid, forKey: "uid")
            
            AppViewModel.shared.userDefaults.synchronize()
            
//            path.append(LoginStateEnum.login)
            self.goToLobby = true
            
        } catch let authErrors as NSError {
            if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                self.popUpHeadText = AuthenticationManager.shared.handleError(errorCode: errorCode)
                print(popUpHeadText)
                
                self.showPopUp = true
                self.isEroor = true
                self.popUpText = "Try again"
            }
        }
    }
    
    func googleSingIn() async {
        do {
            try await  AuthenticationManager.shared.googleSingIn()
            self.goToLobby = true
        } catch {
            print(error)
        }
    }
}
