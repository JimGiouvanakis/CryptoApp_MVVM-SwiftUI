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
    
    // MARK: - Properties
    
    @State private var viewModel: LoginViewModel = .init()
    
    // MARK: - View
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                self.makeMainView()
            }
            .navigationDestination(isPresented: $viewModel.goToLobby) {
                LobbyView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $viewModel.goToCreate) {
                CreateAccountView()
            }
            .fullScreenCover(isPresented: $viewModel.showPopUp) {
                PopUpView(isError: $viewModel.isEroor, popUpHeadText: $viewModel.popUpHeadText, popUpText: $viewModel.popUpText)
            }
        }
        .accentColor(.purple)
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    private func makeMainView() -> some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            self.makeHeaderTexts()
            
            self.makeTextFields()
            
            self.makeSignInButtons()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.black)
    }
    
    @ViewBuilder
    private func makeHeaderTexts() -> some View {
        VStack {
            Image(.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text("Sing in")
                .font(.title)
                .foregroundColor(.purple)
            
            Text("Sing in to your account")
                .font(.title2)
                .foregroundColor(.purple)
                .opacity(0.7)
                .padding(10)
        }
    }
    
    @ViewBuilder
    private func makeTextFields() -> some View {
        VStack {
            TextField(" ", text: $viewModel.emailTextFieldText)
                .placeholder(when: viewModel.emailTextFieldText.isEmpty) {
                    Text("Email Address")
                        .foregroundColor(Color.purple)
                        .padding(.vertical)
                }
                .onSubmit {
                    Task { await viewModel.singInUser() }
                }
                .padding(.leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 1)
                )
                .padding(.bottom)
            
            
            SecureField(" ", text: $viewModel.passwordTextFieldText)
                .placeholder(when: viewModel.passwordTextFieldText.isEmpty) {
                    Text("Password")
                        .foregroundColor(Color.purple)
                        .padding(.vertical)
                }
                .onSubmit {
                    Task { await viewModel.singInUser() }
                }
                .padding(.leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 1)
                )
        }
        .foregroundColor(.purple)
        .padding()
    }
    
    @ViewBuilder
    private func makeSignInButtons() -> some View {
        VStack(spacing: 0) {
            self.makeSingInButton()
            
            self.makeGoogleSingInButton()
            
            self.makeNoUserButton()
        }
    }
    
    @ViewBuilder
    private func makeSingInButton() -> some View {
        Button {
            Task { await viewModel.singInUser() }
        } label: {
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple)
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                
                Text("Sing In")
                    .padding(.vertical)
            }
        }
        .foregroundColor(.black)
        .padding()
    }
    
    @ViewBuilder
    private func makeGoogleSingInButton() -> some View {
        Button {
            Task { await viewModel.googleSingIn() }
        } label: {
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple)
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                
                HStack {
                    Image(.googleIcon)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.black)
                    
                    Text("Google Sing In")
                }
                .padding(.vertical)
            }
        }
        .foregroundColor(.black)
        .padding()
    }
    
    @ViewBuilder
    private func makeNoUserButton() -> some View {
        Button {
            viewModel.goToCreate.toggle()
        } label: {
            Text("New User? Create Account Here")
        }
        .buttonStyle(.borderedProminent)
        .tint(.clear)
        .foregroundColor(.purple)
        .buttonBorderShape(.roundedRectangle)
        .padding(10)
    }
    
    // MARK: - Methods
    
    
    // ..
}


#Preview {
    LoginView()
}
