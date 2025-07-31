//
//  NFT_AppApp.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 14/11/24.
//

import SwiftUI
import Firebase

@main
struct NFT_AppApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
        print("Check Firebase ")
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
