//
//  TabCustomView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI

struct TabCustomView: View {
    
    @Binding var selectedTab: TabBarSelection
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTab = .home
            }) {
                Image(systemName: "house")
                    .font(.title)
                    .padding(.trailing,50)
                    .foregroundColor(.purple)
            }
            
            Button(action: {
                selectedTab = .search
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .padding(.trailing,50)
                    .foregroundColor(.purple)
            }
            
            Button(action: {
                selectedTab = .favorites
            }) {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .padding(.trailing,50)
                    .foregroundColor(.purple)
            }
            
            Button(action: {
                selectedTab = .settings
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.purple)
            }
        }
        .frame(width: 400)
        .background(Color.black)
    }
}

//#Preview {
//    TabCustomView()
//}
