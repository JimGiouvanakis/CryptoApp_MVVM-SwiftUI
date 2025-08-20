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
}
