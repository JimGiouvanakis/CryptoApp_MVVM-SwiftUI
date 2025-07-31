//
//  ContentViewModel.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 9/12/24.
//

import Foundation
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var uiModel: [ContentView.UIModel] = []
    
}
