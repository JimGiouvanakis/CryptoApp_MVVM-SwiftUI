//
//  LobbyView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI

struct LobbyView: View {
    
    // MARK: - Properties
    
    @State var viewModel = LobbyViewModel()
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            self.makeMainView()
                .navigationDestination(isPresented: $viewModel.popToLogin) {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                }
                .sheet(isPresented: $viewModel.showFavorite) {
                    FavoriteView(favoriteItemList: $viewModel.favoriteItemList)
                }
                .onAppear() {
                    Task { await viewModel.getData() }
                }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    private func makeMainView() -> some View {
        VStack {
            Spacer()
            
            self.makeHeader()
            
            self.makeTabView()
            
            self.makeTabBar()
            
        }
        .background(Color.black)
        .ignoresSafeArea(.all ,edges: .bottom)
    }
    
    @ViewBuilder
    private func makeHeader() -> some View {
        HStack {
            Text("NFT LIST")
                .foregroundColor(.purple)
                .font(.largeTitle)
            Spacer()
            
            Button {
                viewModel.showFavorite.toggle()
            } label: {
                Image(systemName: "suit.heart.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purple)
                    .frame(width: 30, height: 35)
            }
        }
        .padding(.vertical,8)
        .background(Color.black.ignoresSafeArea())
        
    }
    
    @ViewBuilder
    private func makeTabView() -> some View {
        if viewModel.tabViewSelect == .home {
            ContentView(nfts: $viewModel.nfts, favoriteItemList: $viewModel.favoriteItemList)
        } else if viewModel.tabViewSelect == .search {
            SearchView(nfts: $viewModel.nfts, filteredNFTs: [])
        } else if viewModel.tabViewSelect == .favorites{
            FavoriteView(favoriteItemList: $viewModel.favoriteItemList)
        } else if viewModel.tabViewSelect == .settings{
            SettingView(loginInView: $viewModel.popToLogin)
        }
    }
    
    @ViewBuilder
    private func makeTabBar() -> some View {
        HStack(spacing: 20) {
            Button(action: {
                viewModel.tabViewSelect = .home
            }) {
                Image(systemName: "house")
                    .font(.title)
                    .padding()
                    .foregroundColor(.purple)
            }
            
            Button(action: {
                viewModel.tabViewSelect = .search
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .padding()
                    .foregroundColor(.purple)
            }
            .padding(.horizontal,8)
            
            Button(action: {
                viewModel.tabViewSelect = .favorites
            }) {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.purple)
            }
            .padding(.horizontal,8)
            
            Button(action: {
                viewModel.tabViewSelect = .settings
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.purple)
            }
        }
        .background(Color.black)
    }
    
    // MARK: - Methods
    
    // ..
}


#Preview {
    LobbyView()
}
