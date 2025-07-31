//
//  CreateAccountView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 2/12/24.
//

import Foundation
import SwiftUI
import FirebaseAuth


struct CreateAccountView : View {
    
    @State private var emailTextFieldText: String = ""
    @State private var passwordTextFieldText: String = ""
    @State private var showPopUp: Bool = false
    @State private var popUpText: String = ""
    @State private var popUpHeadText: String = ""
    @State private var isEroor: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Icon")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
                Text("Sing Up")
                    .font(.title)
                    .foregroundColor(.purple)
                
                Text("Create your account")
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
                    Task {let status = await createUser(email: emailTextFieldText , password: passwordTextFieldText)
                        if status == true {
                            //                            dismiss()
                            showPopUp = true
                            isEroor = false
                            popUpHeadText = "Complete"
                            popUpText = "Your Account is Created"
                        } else if status == false {
                            showPopUp = true
                            isEroor = true
                            popUpText = "Try again"
                        }
                    }
                } label: {
                    Text("Sing Up")
                        .padding([.leading,.trailing],140)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .foregroundColor(.black)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
                
                Button {
                    
                } label: {
                    Text("Terms & Policy")
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundColor(.purple)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
                
                Color.black.ignoresSafeArea()
                
            }
            .fullScreenCover(isPresented: $showPopUp) {
                PopUpView(isError: $isEroor, popUpHeadText: $popUpHeadText, popUpText: $popUpText)
            }
            .background(Color.black)
            .accentColor(.purple)
        }
    }
    
    func createUser(email: String, password: String) async -> Bool? {
        do {
            try await  AuthenticationManager.shared.createUser(email: email, password: password)
            
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
}

#Preview {
    CreateAccountView()
}
