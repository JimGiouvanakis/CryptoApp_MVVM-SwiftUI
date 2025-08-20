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
                ForEach( uiModel.filter { $0.floorPrice > "1.5"}, id: \.id) { item in
                    VStack {
                        Button {
                            self.didTapItem(item.name)
                        } label: {
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.gray, lineWidth: 4)
                                .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                                .opacity(0.5)
                                .aspectRatio(contentMode: .fit)
                                .overlay {
                                    VStack {
                                        RemoteImageView(urlString: item.imageURL)
                                            .cornerRadius(20)
                                            .padding()
                                            .shadow(radius: 50, x: 50, y: 50)
                                            .aspectRatio(contentMode: .fit)
                                        
                                        Text(item.name)
                                            .foregroundColor(.purple)
                                            .font(.caption)
                                        
                                    }
                                    .padding()
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LobbyView()
}
