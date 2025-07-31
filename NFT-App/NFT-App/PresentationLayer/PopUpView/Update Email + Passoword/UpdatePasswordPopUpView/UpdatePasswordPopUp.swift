//
//  UpdatePasswordPopUp.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 4/12/24.
//

import SwiftUI
import FirebaseAuth

struct UpdatePasswordPopUp: View {
    @State var newPasswordTextFieldText: String = ""
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var showPopUp: Bool = false
    @State var isEroor: Bool = false
    @State var popUpText: String = ""
    @State var popUpHeadText: String = ""
    @State var isShowPasswordView: Bool = true
    
    @Binding var passwordPopUp: Bool
    @Binding var userStatus: UserLogStatus
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            if isShowPasswordView {
                makePasswordView()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        )
                    )
                
            } else {
                makeLoginView()
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    )
                )
            }
        }
        .animation(.easeInOut, value: isShowPasswordView)
        .background(BackgroundClearView())
    }
    
    @ViewBuilder
    func makePasswordView() -> some View {
        VStack {
            Image(systemName: "lock")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            Text("Change your Password")
                .font(.title)
                .padding(10)
            
            Text("Insert your new Password")
                .font(.title3)
                .opacity(0.7)
                .padding(10)
            
            
            SecureField(" ", text: $newPasswordTextFieldText)
                .placeholder(when: newPasswordTextFieldText.isEmpty) {
                    Text("New Password").foregroundColor(Color.purple)
                }
                .padding(10)
                .foregroundColor(.purple)
                .background(
                    Color.black
                        .cornerRadius(6)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.purple, lineWidth: 1)
                )
                .padding()
                .tint(.purple)
            
            Button {
                if newPasswordTextFieldText.isEmpty {
                    showPopUp = true
                    isEroor = true
                    popUpHeadText = "Invalid Password"
                    popUpText = "Try again"
                    return
                } else {
                    Task {
                        do {
                            try await AuthenticationManager.shared.resetPassword(password: newPasswordTextFieldText)
                            passwordPopUp = false
                        } catch let authErrors as NSError {
                            if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                                let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                                isEroor = true
                                if errorCode == .internalError {
                                    popUpHeadText = "Invalid Password"
                                    showPopUp = true
                                } else if errorCode == .requiresRecentLogin {
                                    try AuthenticationManager.shared.singOut()
                                    userStatus = .loggedOut
                                    isShowPasswordView = false
                                } else {
                                    popUpHeadText = error
                                    showPopUp = true
                                }
                                popUpText = "Try again"
                               
                            }
                        }
                    }
                }
            }label: {
                Text("Send")
                    .padding([.leading,.trailing],115)
            }
            .padding(10)
            .background(Color.black)
            .foregroundColor(.purple)
            .cornerRadius(8)
        }
        .fullScreenCover(isPresented: $showPopUp) {
            PopUpView(isError: $isEroor, popUpHeadText: $popUpHeadText, popUpText: $popUpText)
        }
        .frame(width: 315, height: 400)
        .background(Color.purple)
        .cornerRadius(12)
        .shadow(radius: 10)
        .foregroundColor(.black)
        
    }
    
    @ViewBuilder
    func makeLoginView() -> some View {
        ZStack {
            VStack {
                Text("Sing in to your account to verify User")
                    .font(.title2)
                    .opacity(0.7)
                    .padding(10)
                    .multilineTextAlignment(.center)
                
                TextField(" ", text: $emailTextFieldText)
                    .placeholder(when: emailTextFieldText.isEmpty) {
                        Text("Email Address").foregroundColor(Color.purple)
                    }
                    .padding(10)
                    .foregroundColor(.purple)
                    .background(
                        Color.black
                            .cornerRadius(6)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                    .padding()
                    .tint(.purple)
                
                SecureField(" ", text: $passwordTextFieldText)
                    .placeholder(when: passwordTextFieldText.isEmpty) {
                        Text("Password").foregroundColor(Color.purple)
                    }
                    .padding(10)
                    .foregroundColor(.purple)
                    .background(
                        Color.black
                            .cornerRadius(6)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                    .padding([.leading,.trailing,.bottom])
                    .tint(.purple)
                
                Button {
                    Task {
                        do {
                            try await AuthenticationManager.shared.singInUser(email: emailTextFieldText, password: passwordTextFieldText)
                            try await AuthenticationManager.shared.resetPassword(password: newPasswordTextFieldText)
                            userStatus = .email
                            passwordPopUp = false
                        }  catch let authErrors as NSError {
                            if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                                let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                                isEroor = true
                                popUpHeadText = error
                                popUpText = "Try again"
                                showPopUp = true
                            }
                        }
                    }
                } label: {
                    Text("Send")
                        .padding([.leading,.trailing],115)
                }
                .padding(10)
                .background(Color.black)
                .foregroundColor(.purple)
                .cornerRadius(8)
            }
            .frame(width: 315, height: 320)
            .background(Color.purple)
            .cornerRadius(12)
            .shadow(radius: 10)
            .foregroundColor(.black)
        }
        .fullScreenCover(isPresented: $showPopUp) {
            PopUpView(isError: $isEroor, popUpHeadText: $popUpHeadText, popUpText: $popUpText)
        }
    }
}


//#Preview {
//    UpdatePasswordPopUp()
//}
