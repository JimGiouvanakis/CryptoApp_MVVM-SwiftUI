//
//  ContentViewModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 9/12/24.
//

import Foundation
import SwiftUI
import Observation

@MainActor
@Observable
class ContentViewModel {
    
    var uiModel: [ContentView.UIModel] = []
    
    var showDetails = false
    var showCart = false
    var pushToDetails = false
    var navigationNFT: NFT?
    
    func makeNewListViewUIModel(nfts: [NFT]) -> [NewListView.UIModel] {
        return nfts.compactMap { nft in
                .init(imageURL: nft.imageUrl, numberOfOwners: nft.numberOwners)
        }
    }
    
    func makeTopSearchViewUIModel(nfts: [NFT]) -> [TopSearchesView.UIModel] {
        return nfts.compactMap { nft in
                .init(name: nft.name, imageURL: nft.imageUrl, numberOfOwners: nft.numberOwners, floorPrice: nft.floorPrice.amount)
        }
    }
}
