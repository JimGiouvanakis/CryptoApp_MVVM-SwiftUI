//
//  NetworkCall.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 4/10/24.
//

import SwiftUI

struct NetworkCall {
    
    let headers = [
        "x-rapidapi-key" : Constants.apiKey,
        "x-rapidapi-host": Constants.apiHost
    ]
    
    func fetchData() async throws -> Data {
        
        guard let url = URL(string: Constants.apiURL) else {
            throw NetworkError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                guard error == nil else {
                    continuation.resume(throwing: NetworkError.generalError)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    if  let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json") {
                        do {
                            let data = try Data(contentsOf: fileLocation)
                            print("Mock Data Activated")
                            continuation.resume(returning: data)
                            return
                        } catch {
                            print("Mock Data Error")
                            continuation.resume(throwing: NetworkError.degodingError)
                            return
                        }
                    } else {
                        print("Mock Data Error")
                        continuation.resume(throwing: NetworkError.noData)
                        return
                    }
            }

                
                guard let data = data else {
                    continuation.resume(throwing: NetworkError.noData)
                    return
                }
                continuation.resume(returning: data)
                return
            }
            task.resume()
        }
    }
//    private func mapResponseToDomain(model: [NFTEntity]) -> [NFT] {
//        var nft: [NFT] = []
//        for item in model {
//            nft.append(.init(entity: item))
//        }
//        return nft
//    }
    
//    private func getMockData() -> [NFT] {
//
//        let mockData: [NFT] = [
//
//            NFT(
//                contractAddress: "0xbd3531da5cf5857e7cfaa92426877b022e612cf8",
//                name : "PudgyPenguins",
//                slug :  "pudgypenguins",
//                imageUrl : "https://images.blur.io/_blur-prod/0xbd3531da5cf5857e7cfaa92426877b022e612cf8/760-b91995265fdeb95a",
//                totalSupply : 8888,
//                numberOwners :5259,
//                floorPrice: FloorPrice(amount:"9.5099998" , unit:"ETH"),
//                floorPriceOneDay: FloorPrice(amount:"9.79897434" , unit:"ETH"),
//                floorPriceOneWeek: FloorPrice(amount:"9.79897434" , unit:"ETH"),
//                volumeFifteenMinute : "",
//                volumeOneDay:FloorPrice(amount:"283.20822311000006" , unit:"ETH"),
//                volumeOneWeek:FloorPrice(amount:"1194.627421809999" , unit:"ETH"),
//                bestCollectionBid:FloorPrice(amount:"9.29", unit:"ETH"),
//                totalCollectionBidValue:FloorPrice(amount:"321.69" , unit:"ETH"),
//                traitFrequencies: ""
//            ),
//
//            NFT(
//                contractAddress: "0xc374a204334d4edd4c6a62f0867c752d65e9579c",
//                name : "Project AEON",
//                slug :  "project-aeon",
//                imageUrl : "https://images.blur.io/_blur-prod/0xc374a204334d4edd4c6a62f0867c752d65e9579c/1331-93ff83f5ca654db2",
//                totalSupply : 3333,
//                numberOwners :1017,
//                floorPrice: FloorPrice(amount:"1.5" , unit:"ETH"),
//                floorPriceOneDay: FloorPrice(amount:"0.784387" , unit:"ETH"),
//                floorPriceOneWeek: FloorPrice(amount:"0.784387" , unit:"ETH"),
//                volumeFifteenMinute : "",
//                volumeOneDay:FloorPrice(amount:"159.901174" , unit:"ETH"),
//                volumeOneWeek:FloorPrice(amount:"489.4858478" , unit:"ETH"),
//                bestCollectionBid:FloorPrice(amount:"1.21" , unit:"ETH"),
//                totalCollectionBidValue:FloorPrice(amount:"77.09" , unit:"ETH"),
//                traitFrequencies: ""
//            ),
//        ]
//        return mockData
//    }
}
