//
//  HeaderView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    
    @Binding var favoriteItemList: [NFT]
    
    @State var showModal = false
    
    var body: some View {
        HStack {
            Text("NFT LIST")
                .foregroundColor(.purple)
                .font(.largeTitle)
            Spacer()
            
            Button(action: {
                self.showModal.toggle()
//                FavoriteView(favoriteItemList: $favoriteItemList)
            }, label: {
                Image(systemName: "suit.heart.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purple)
                    .frame(width: 30, height: 35)
                
            })
            .sheet(isPresented: $showModal) {
                FavoriteView(favoriteItemList: $favoriteItemList)
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}



//#Preview {
//    HeaderView()
//}
