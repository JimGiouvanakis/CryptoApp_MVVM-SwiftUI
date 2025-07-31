//
//  LobbyView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI

struct LobbyView: View {
    
    @StateObject var viewModel = LobbyViewModel()
    
    @State var loginStatus: Bool = true
    @State var tabViewSelect: TabBarSelection = .home
    @State var loginInView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
//                    .navigationBarBackButtonHidden(true)
                
                HeaderView(favoriteItemList: $viewModel.favoriteItemList)
                    .padding([.leading,.trailing],5)
                    .background(Color.black.ignoresSafeArea())
                
                if tabViewSelect == .home {
                    ContentView(nfts: $viewModel.nfts, favoriteItemList: $viewModel.favoriteItemList)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if tabViewSelect == .search {
                    SearchView(nfts: $viewModel.nfts, filteredNFTs: [])
                } else if tabViewSelect == .favorites{
                    FavoriteView(favoriteItemList: $viewModel.favoriteItemList)
                } else if tabViewSelect == .settings{
                    SettingView(loginInView: $loginInView)
                }
                
                TabCustomView(selectedTab: $tabViewSelect)
                
                NavigationLink(destination:LoginView() ,isActive: $loginInView) {
                    EmptyView()
                }
                
            }
            .background(Color.black)
            .onAppear() {
                Task { await viewModel.getData() }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


//#Preview {
//    LobbyView()
//}
