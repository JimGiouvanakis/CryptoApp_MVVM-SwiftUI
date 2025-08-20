//
//  LobbyViewModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI
import Observation

@MainActor
@Observable
class LobbyViewModel  {
    
    var nfts: [NFT] =  []
    var clickedItem: NFT?
    var favoriteItemList: [NFT] = []
    
    var showFavorite: Bool = false
    
    var loginStatus: Bool = true
    var tabViewSelect: TabBarSelection = .home
    var popToLogin: Bool = false
    
    let getNFTUseCase = GetNFTUseCase()
    
    func getData() async {
        let nfts = await getNFTUseCase.execute()
        self.nfts = nfts
    }
}
