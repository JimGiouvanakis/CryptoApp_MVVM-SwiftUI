//
//  NewListView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 16/10/24.
//

import SwiftUI

struct NewListView: View {
    
    @State var scrollPosition: Int = 0
    @State var isAutoPlay: Bool = true
    
    var uiModel: [UIModel]
    
    var timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    
    
    var filteredNFTs: [UIModel] {
        uiModel.filter { $0.numberOfOwners < 1000 }
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $scrollPosition) {
                ForEach(filteredNFTs.indices , id: \.self) { line in
                    ZStack {
                        RemoteImageView(urlString: self.filteredNFTs[line].imageURL)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .shadow(radius: 50, x: 50, y: 50)
                        
                        HStack {
                            VStack {
                                    Text("NEW")
                                        .bold()
                                        .padding(4)
                                        .padding(.horizontal)
                                        .background(Color.yellow)
                                        .cornerRadius(10)
                                        .rotationEffect(.degrees(-30))
                                        .foregroundStyle(Color.black)
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                        }
                        .padding(.vertical)
                    }
                    .tag(line)
                }
            }
        }
        .tabViewStyle(.page)
        .onReceive(timer, perform: { _ in
            withAnimation{
                if scrollPosition == filteredNFTs.count {
                    scrollPosition = 0
                } else {
                    scrollPosition = scrollPosition + 1
                }
            }
        })
    }
}

#Preview {
    LobbyView()
}
