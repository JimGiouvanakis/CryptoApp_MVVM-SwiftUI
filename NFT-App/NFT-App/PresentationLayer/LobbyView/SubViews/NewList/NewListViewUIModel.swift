//
//  NewListViewUIModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 9/12/24.
//

import Foundation
import SwiftUI


extension NewListView {
    
    struct UIModel: Identifiable {
        
        var id: UUID = UUID()
        var imageURL: String
        var numberOfOwners: Int
    }
}
