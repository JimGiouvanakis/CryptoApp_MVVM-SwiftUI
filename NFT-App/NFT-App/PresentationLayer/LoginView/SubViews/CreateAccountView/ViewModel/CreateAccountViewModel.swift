//
//  CreateAccountViewModel.swift
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
final class CreateAccountViewModel {
    
    var emailTextFieldText: String = ""
    var passwordTextFieldText: String = ""
    var showPopUp: Bool = false
    var popUpText: String = ""
    var popUpHeadText: String = ""
    var isEroor: Bool = false
    
    
    func createUser() async {
        do {
            try await  AuthenticationManager.shared.createUser(email: emailTextFieldText, password: passwordTextFieldText)
            showPopUp = true
            isEroor = false
            popUpHeadText = "Complete"
            popUpText = "Your Account is Created"
        } catch let authErrors as NSError {
            if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                print(error)
                popUpHeadText = error
                showPopUp = true
                isEroor = true
                popUpText = "Try again"
            }
        }
    }
}
