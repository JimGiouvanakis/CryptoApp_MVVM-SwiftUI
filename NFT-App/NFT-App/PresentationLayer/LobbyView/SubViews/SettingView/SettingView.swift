//
//  SettingView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 3/12/24.
//

import SwiftUI
import FirebaseAuth

struct SettingView: View {
    
    @State private var showPopUp: Bool = false
    @State private var emailPopUp: Bool = false
    @State private var passwordPopUp: Bool = false
    @State private var showLogin: Bool = false
    @State private var popUpText: String = ""
    @State private var popUpHeadText: String = ""
    @State private var isEroor: Bool = false
    @State private var emailUpdated: Bool = false
    @Binding var loginInView: Bool 
    
    @State private var userStatus: UserLogStatus = .email
    
    var body: some View {
        NavigationView {
            ZStack {
                Spacer()
                HStack {
                    VStack {
                        
                        Text("Settings")
                            .font(.title)
                            .foregroundColor(.purple)
                            .padding(.trailing,210)
                        
                        if userStatus == .email || userStatus == .google {
                            Button {
                                Task { let status = await singOut()
                                    if status == true {
                                        AppViewModel.shared.userDefaults.set("", forKey: "Token")
                                        AppViewModel.shared.userDefaults.set("", forKey: "uid")
                                    
                                        AppViewModel.shared.userDefaults.synchronize()
                                        
                                        userStatus = .loggedOut
                                    }
                                }
                            } label: {
                                Text("Log Out")
                                    .font(.title3)
                                    .padding(.trailing,200)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .foregroundColor(.black)
                            .buttonBorderShape(.roundedRectangle)
                            .padding(10)
                            
                        }
                        
                        if userStatus == .email {
                            Button {
                                passwordPopUp = true
                            } label: {
                                Text("Update Password")
                                    .font(.title3)
                                    .padding(.trailing,115)
                            }
                            
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .foregroundColor(.black)
                            .buttonBorderShape(.roundedRectangle)
                            .padding(10)
                        }
                        
                        if userStatus == .email {
                            Button {
                                emailPopUp = true
                            } label: {
                                Text("Update Email")
                                    .font(.title3)
                                    .padding(.trailing,150)
                            }
                            
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .foregroundColor(.black)
                            .buttonBorderShape(.roundedRectangle)
                            .padding(10)
                        }
                        
                        if userStatus == .loggedOut {
                            Button {
                                self.loginInView = true
                            } label: {
                                Text("Log In")
                                    .font(.title3)
                                    .padding(.trailing,210)
                            }
                            
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .foregroundColor(.black)
                            .buttonBorderShape(.roundedRectangle)
                            .padding(10)
                        }
                        Spacer()
                    }
                    .padding(20)
                    Spacer()
                }
                .fullScreenCover(isPresented: $emailPopUp) {
                    withAnimation(.easeInOut) {
                        UpdateEmailPopUpView(emailPopUp: $emailPopUp, userStatus: $userStatus)
                    }
                }
                .fullScreenCover(isPresented: $passwordPopUp) {
                    withAnimation(.easeInOut) {
                        UpdatePasswordPopUp(passwordPopUp: $passwordPopUp, userStatus: $userStatus)
                    }
                }
                .background(Color.black.ignoresSafeArea())
            }
        }
        .onAppear {
            setStatus()
        }
    }
    
    func singOut() async -> Bool? {
        if userStatus == .email {
            do {
                try AuthenticationManager.shared.singOut()
                return true
            } catch let authErrors as NSError {
                if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                    let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                    print(error)
                    popUpHeadText = error
                    return false
                }
            }
        } else if userStatus == .google {
            do {
                try  AuthenticationManager.shared.singOutGoogle()
                return true
            } catch let authErrors as NSError {
                if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                    let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                    popUpHeadText = error
                    return false
                }
            }
        }
        return nil
    }
    
    func updateEmail(email: String) async -> Bool? {
        do {
            try await AuthenticationManager.shared.updateEmail(email: email)
            return true
        } catch let authErrors as NSError {
            if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                print(error)
                popUpHeadText = error
                return false
            }
        }
        return nil
    }
    
    func setStatus() {
        userStatus = AppViewModel.shared.userLogStatus
    }
}

//#Preview {
//    SettingView()
//}
