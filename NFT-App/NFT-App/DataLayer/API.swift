//
//  API.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 18/10/24.
//

import Foundation

struct NFTAPI {
    
    func getNFTs() async -> [NFTEntity] {
        
        do {
            let data = try await  NetworkCall().fetchData()
            
            return try JSONDecoder().decode([NFTEntity].self, from: data)
            
        }catch {
            print(error)
            return []
        }
    }
}
