//
//  ContenViewUIModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 9/12/24.
//

import Foundation
import SwiftUI


extension ContentView {
    
    struct UIModel: Identifiable {
        var id: UUID = UUID()
        var newListUIModel: [NewListView.UIModel]
        var topSearchUIModel: [TopSearchesView.UIModel]
    }
    
    func makeNewListViewUIModel() -> [NewListView.UIModel] {
        var array: [NewListView.UIModel] = []
        for nft in nfts {
            array.append (
                .init (
                    imageURL: nft.imageUrl,
                    numberOfOwners: nft.numberOwners
                )
            )
        }
        return array
    }
    
    func makeTopSearchViewUIModel() -> [TopSearchesView.UIModel] {
        var array: [TopSearchesView.UIModel] = []
        for nft in nfts {
            array.append (
                .init (
                    name: nft.name,
                    imageURL: nft.imageUrl,
                    numberOfOwners: nft.numberOwners,
                    floorPrice: nft.floorPrice.amount
                )
            )
        }
        return array
    }
    
}
