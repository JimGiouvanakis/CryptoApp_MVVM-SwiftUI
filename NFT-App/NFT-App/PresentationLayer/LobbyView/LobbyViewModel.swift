//
//  LobbyViewModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI

@MainActor
class LobbyViewModel: ObservableObject  {
    
    @Published var nfts: [NFT] =  []
    @Published var clickedItem: NFT?
    @Published var favoriteItemList: [NFT] = []
    
    let getNFTUseCase = GetNFTUseCase()
    
    func getData() async {
        let nfts = await getNFTUseCase.execute()
        self.nfts = nfts
    }
}
