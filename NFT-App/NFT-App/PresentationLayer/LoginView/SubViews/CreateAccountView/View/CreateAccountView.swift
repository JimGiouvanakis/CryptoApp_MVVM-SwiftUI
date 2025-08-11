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
    
    // MARK: - Properties
    
    @State private var viewModel: CreateAccountViewModel = .init()
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            self.makeMainView()
                .fullScreenCover(isPresented: $viewModel.showPopUp) {
                    PopUpView(isError: $viewModel.isEroor, popUpHeadText: $viewModel.popUpHeadText, popUpText: $viewModel.popUpText)
                }
                .background(Color.black)
                .accentColor(.purple)
        }
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    private func makeMainView() -> some View {
        VStack {
            Spacer()
            
            self.makeHeaderTexts()
            
            self.makeTextFields()
            
            self.makeButtons()
            
        }
    }
    
    @ViewBuilder
    private func makeHeaderTexts() -> some View {
        VStack {
            Image(.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text("Sing Up")
                .font(.title)
            
            Text("Create your account")
                .font(.title2)
                .opacity(0.7)
                .padding(9)
        }
        .foregroundColor(.purple)
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
    private func makeButtons() -> some View {
        VStack {
                Button {
                    Task { await viewModel.createUser() }
                } label: {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.purple)
                            .frame(height: UIScreen.main.bounds.height * 0.05)
                        
                        Text("Sing Up")
                            .padding(.vertical)
                    }
                }
                .foregroundColor(.black)
                .padding()
            
            Button {
                // ..
            } label: {
                Text("Terms & Policy")
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.clear)
            .foregroundColor(.purple)
            .buttonBorderShape(.roundedRectangle)
            .padding(10)
        }
    }
    
    // MARK: - Methods
    
    // ..
    
    
}

#Preview {
    CreateAccountView()
}
