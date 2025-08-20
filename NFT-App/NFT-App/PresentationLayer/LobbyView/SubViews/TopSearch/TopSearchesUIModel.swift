//
//  TopSearchesUIModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 10/12/24.
//

import Foundation
import SwiftUI

extension TopSearchesView {
    
    struct UIModel: Identifiable {
        var id: UUID = UUID()
        var name: String
        var imageURL: String
        var numberOfOwners: Int
        var floorPrice: String
    }
    
}


