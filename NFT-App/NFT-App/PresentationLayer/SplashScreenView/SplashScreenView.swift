//
//  SplashScreenView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 14/10/24.
//

import SwiftUI
import FirebaseAuth

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.6
    @State private var opacity = 0.5       
    @State var userToken : String?
    @State var uid : String?
    @State var isLoggedIn : Bool = false
    @State var oldUserToken: String?
    @State var olduid: String?
    
    var body: some View {
        if isActive {
            if isLoggedIn {
                LobbyView()
            } else {
                LoginView()
            }
        } else {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    VStack {
                        Text("NFT")
                            .font(.system(size: 70))
                            .foregroundColor(.purple.opacity(0.8))
                        Text("Non Fucntional Tokens")
                            .font(.system(size: 30))
                            .foregroundColor(.purple.opacity(0.8))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity  = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                    
                    Task {
                        oldUserToken = AppViewModel.shared.userDefaults.string(forKey: "Token")
                        olduid = AppViewModel.shared.userDefaults.string(forKey: "uid")
                        if oldUserToken != "" && olduid != "" {
                            if let tokenResult = try await Auth.auth().currentUser?.getIDTokenResult() {
                                userToken = tokenResult.token
                                let user = Auth.auth().currentUser
                                uid = user?.uid
                                if userToken == oldUserToken && uid == olduid {
                                    AppViewModel.shared.userLogStatus = .email
                                    isLoggedIn = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


//#Preview {
//    SplashScreenView()
//}
