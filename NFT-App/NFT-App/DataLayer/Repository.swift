//
//  Repository.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 18/10/24.
//

import Foundation

struct NFTRepository {
    
    let api = NFTAPI()
    
    func getNFTs() async -> [NFT] {
        let result = await api.getNFTs()
        return mapResponseToDomain(model: result)
    }
    
    private func mapResponseToDomain(model: [NFTEntity]) -> [NFT] {
        var nft: [NFT] = []
        for item in model {
            nft.append(.init(entity: item))
        }
        return nft
    }
}
