//
//  SplashView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 14/10/24.
//

import SwiftUI
import FirebaseAuth

struct SplashView: View {
    
    // MARK: - Properties
    
    @State private var viewModel: SplashViewModel = .init()
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            self.makeMainView()
        }
        .onAppear {
            Task { await viewModel.setup() }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                viewModel.isActive = true
            }
        }
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    private func makeMainView() -> some View {
        if viewModel.isActive {
            self.makeActiveView()
        } else {
            self.makeLoadingView()
        }
    }
    
    @ViewBuilder
    private func makeActiveView() -> some View {
        if viewModel.isLoggedIn {
            LobbyView()
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    private func makeLoadingView() -> some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Text("NFT")
                        .font(.system(size: 70))
                        .foregroundColor(.purple.opacity(0.8))
                    Text("Non Fucntional Tokens")
                        .font(.system(size: 30))
                        .foregroundColor(.purple.opacity(0.8))
                }
                .scaleEffect(viewModel.size)
                .opacity(viewModel.opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        viewModel.size = 0.9
                        viewModel.opacity  = 1.0
                    }
                }
            }
        }
    }
    
    // MARK: - Methods
    
    // ..
}


//#Preview {
//    SplashScreenView()
//}
