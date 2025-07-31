//
//  AuthenticationManager.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 2/12/24.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func createUser(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func singInUser(email: String, password: String) async throws  {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: password)
            AppViewModel.shared.userLogStatus = .email
        } catch {
            throw error
        }
    }
    @MainActor
    func googleSingIn() async throws {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw GoogleAuthenticationError.runtimeError("no firbase clientID found")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let rootViewController = scene?.windows.first?.rootViewController
        else {
            throw GoogleAuthenticationError.runtimeError("There is no root view controller!")
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController
        )
        let user = result.user
        guard let idToken = user.idToken?.tokenString else {
            throw GoogleAuthenticationError.runtimeError("Unexpected error occurred, please retry")
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken, accessToken: user.accessToken.tokenString
        )
        try await Auth.auth().signIn(with: credential)
        
        AppViewModel.shared.userLogStatus = .google
    }
    
    
    func resetPassword(password: String) async throws  {
        do {
            try await Auth.auth().currentUser?.updatePassword(to: password)
        } catch {
            print(error)
            throw (error)
        }
    }
    
    func updateEmail(email: String) async throws {
        guard (Auth.auth().currentUser?.email) != nil else { return }
        do {
            try await Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: email)
        } catch {
            print(error)
            throw error
        }
    }
    
    func singOut() throws {
        do {
            try Auth.auth().signOut()
            AppViewModel.shared.userLogStatus = .loggedOut
        } catch {
            print(error)
            throw error
        }
    }
    
    func singOutGoogle() throws {
        GIDSignIn.sharedInstance.signOut()
        AppViewModel.shared.userLogStatus = .loggedOut
    }
    
    func  handleError(errorCode: AuthErrorCode) -> String {
        switch errorCode {
        case .invalidEmail:
            return "Invalid Email"
        case .userDisabled:
            return "User is Disabled"
        case .invalidCredential:
            return "Invalid Credential"
        case .emailAlreadyInUse:
            return "Email is Already In Use"
        case .networkError:
            return "Check your Network"
        case .wrongPassword:
            return "Invalid Password"
        case .weakPassword:
            return "Weak Password"
        case .internalError:
            return "Internal Error"
        case .requiresRecentLogin:
            return "Sing in Again"
        default:
            return "Unknown error"
        }
    }
}

