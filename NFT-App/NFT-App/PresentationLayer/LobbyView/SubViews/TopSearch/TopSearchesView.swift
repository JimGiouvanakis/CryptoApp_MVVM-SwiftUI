//
//  TopSearchesView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 17/10/24.
//

import SwiftUI

struct TopSearchesView: View {

    var uiModel: [Self.UIModel]
    
    var didTapItem: (String) -> ()?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(uiModel.filter {  nft in
                    if nft.floorPrice > "1.5" {
                        return true
                    } else {
                        return false
                    }
                }, id: \.id) { item in
                    VStack {
                        AsyncImage(url: URL(string: item.imageURL)) { result in
                            result.image?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding()
                                .shadow(radius: 50, x: 50, y: 50)
                        }
                        
                        Text(item.name)
                            .foregroundColor(.purple)
                            .font(.caption)
                        
                    }
                    .onTapGesture {
                        didTapItem(item.name)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 4)
                            .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                            .opacity(0.5)
                    )
                }
            }
        }
    }
}

//#Preview {
//    TopSearchesView()
//}

