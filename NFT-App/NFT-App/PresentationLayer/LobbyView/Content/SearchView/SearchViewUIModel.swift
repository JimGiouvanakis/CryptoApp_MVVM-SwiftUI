//
//  SearchViewUIModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 10/12/24.
//

import Foundation
import SwiftUI

extension SearchView {
    
    struct UIModel: Identifiable {
        var id: UUID = UUID()
        var name: String
        var imageURL: String
        var floorPricePrice: String
        var floorPriceUnit: String
    }
    
    func makeUIModel(nfts: [NFT]) -> [UIModel] {
        var array: [UIModel] = []
        for nft in nfts {
            array.append (
                .init (
                    name: nft.name,
                    imageURL: nft.imageUrl,
                    floorPricePrice: nft.floorPrice.amount,
                    floorPriceUnit: nft.floorPrice.unit
                )
            )
        }
        return array
    }
    
}
