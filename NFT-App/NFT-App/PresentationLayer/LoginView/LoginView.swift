//
//  LoginView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 2/12/24.
//

import Foundation
import SwiftUI
import FirebaseAuth


struct LoginView: View {
    
    @State private var emailTextFieldText: String = ""
    @State private var passwordTextFieldText: String = ""
    @State private var pushCreateView: Bool = false
    @State private var openLobby: Bool = false
    @State private var showPopUp: Bool = false
    @State private var popUpText: String = ""
    @State private var popUpHeadText: String = ""
    @State private var isEroor: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                    .navigationBarBackButtonHidden(true)
                
                Image("Icon")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding()
                
                Text("Sing in")
                    .font(.title)
                    .foregroundColor(.purple)
                
                Text("Sing in to your account")
                    .font(.title2)
                    .foregroundColor(.purple)
                    .opacity(0.7)
                    .padding(9)
                
                TextField(" ", text: $emailTextFieldText)
                    .placeholder(when: emailTextFieldText.isEmpty) {
                        Text("Email Address").foregroundColor(Color.purple)
                    }
                    .padding(10)
                    .foregroundColor(.purple)
                    .background(Color.black)
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
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                    .padding()
                    .tint(.purple)
                
                Button {
                    Task { let status = await singInUser(email: emailTextFieldText , password: passwordTextFieldText)
                        if status == true {
                            
                            let tokenResult = try await Auth.auth().currentUser?.getIDTokenResult()
                            let userToken = tokenResult?.token
                            let user = Auth.auth().currentUser
                            let uid = user?.uid
                            AppViewModel.shared.userDefaults.set(userToken, forKey: "Token")
                            AppViewModel.shared.userDefaults.set(uid, forKey: "uid")
                            
                            AppViewModel.shared.userDefaults.synchronize()
                            
                            openLobby = true
                        } else if status == false {
                            showPopUp = true
                            isEroor = true
                            popUpText = "Try again"
                        }
                    }
                } label: {
                    Text("Sing In")
                        .padding([.leading,.trailing],145)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .foregroundColor(.black)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
                
                Button {
                    Task { let status = await googleSingIn()
                        if status == true {
                            openLobby = true
                        } else if status == false {
                            showPopUp = true
                            isEroor = true
                            popUpText = "Try again"
                        }}
                } label: {
                    HStack {
                        Spacer()
                        Image("Google")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Google Sing In")
                        
                        Spacer()
                    }
                    .padding([.leading,.trailing],80)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .foregroundColor(.black)
                .buttonBorderShape(.roundedRectangle)
                .padding(12)
                
                Button {
                    pushCreateView = true
                } label: {
                    Text("New User? Create Account Here")
                }
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundColor(.purple)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
                
                NavigationLink(destination:CreateAccountView() ,isActive: $pushCreateView) {
                    EmptyView()
                }
                .onAppear {
                    let appearance = UINavigationBarAppearance()
                    appearance.backgroundColor = UIColor.black
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                }
                Color.black.ignoresSafeArea()
                
                NavigationLink(destination: LobbyView() ,isActive: $openLobby) {
                    EmptyView()
                }
                
                Color.black.ignoresSafeArea()
            }
            .fullScreenCover(isPresented: $showPopUp) {
                PopUpView(isError: $isEroor, popUpHeadText: $popUpHeadText, popUpText: $popUpText)
            }
            .background(Color.black.ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(.purple)
        
    }
    
    
    func singInUser(email: String, password: String) async -> Bool? {
        do {
            try await  AuthenticationManager.shared.singInUser(email: email, password: password)
            return true
        } catch let authErrors as NSError {
            if let errorCode = AuthErrorCode(rawValue: authErrors.code) {
                let error = AuthenticationManager.shared.handleError(errorCode: errorCode)
                popUpHeadText = error
                print(error)
                
                return false
            }
        }
        return nil
    }
    
    func googleSingIn() async -> Bool? {
        do {
            try await  AuthenticationManager.shared.googleSingIn()
            return true
        } catch {
            print(error)
            
            return false
        }
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


//#Preview {
//    LoginView()
//}
