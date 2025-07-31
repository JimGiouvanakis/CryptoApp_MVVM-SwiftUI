//
//  LoginPopUp.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 3/12/24.
//

import SwiftUI

struct LoginPopUp: View {
    
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Sing in to your account to verify User")
                    .font(.title2)
                    .opacity(0.7)
                    .padding(10)
                    .multilineTextAlignment(.center)
                
                TextField(" ", text: $emailTextFieldText)
                    .placeholder(when: emailTextFieldText.isEmpty) {
                        Text("New Email Address").foregroundColor(Color.purple)
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
                    Task { try await AuthenticationManager.shared.singInUser(email: emailTextFieldText, password: passwordTextFieldText) }
                    
                 dismiss()
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
        .background(BackgroundClearView().opacity(0.3))
    }
}

#Preview {
    LoginPopUp()
}
