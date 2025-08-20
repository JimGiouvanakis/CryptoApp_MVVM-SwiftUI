//
//  ContentView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 3/10/24.
//

import SwiftUI

struct ContentView : View {
    
    @StateObject var viewModel = ContentViewModel()
    
    @State private var showDetails = false
    @State private var showCart = false
    @State private var pushToDetails = false
    @State var navigationNFT: NFT?
    
    @Binding var nfts: [NFT]
    @Binding var favoriteItemList: [NFT]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    
                    makeNewListView()
                        .frame(width: 200, height: 200)
                    
                    Divider()
                    
                    Text("Top Searches")
                        .font(.title3)
                        .padding(.trailing,250)
                        .foregroundColor(.purple)
                    
                    Spacer()
                        .padding(10)
                    
                    TopSearchesView(uiModel: .constant(makeTopSearchViewUIModel()), didTapItem: { nftname in
                        navigationNFT = findNFT(nftname: nftname)
                        pushToDetails = true
                    })
                    .frame(width: 395, height: 200)
                    .padding()
                    
                    NavigationLink(destination:PriceDetailsView(clickedItem: $navigationNFT) ,isActive: $pushToDetails) {
                        EmptyView()
                    }
                    .onAppear {
                        let appearance = UINavigationBarAppearance()
                        appearance.backgroundColor = UIColor.black
                        UINavigationBar.appearance().standardAppearance = appearance
                        UINavigationBar.appearance().scrollEdgeAppearance = appearance
                    }
                    
                    Spacer()
                        .padding(10)
                    
                    Divider()
                        .padding(10)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 20) {
                            ForEach(nfts, id:\.name) { item in
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: item.imageUrl)){ result in
                                        result.image?
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .frame(width:350, height:300)
                                    
                                    Text(item.name)
                                        .font(.headline)
                                        .bold()
                                        .padding(6)
                                    
                                    HStack(spacing: 70) {
                                        HStack() {
                                            Text(item.floorPrice.amount)
                                                .font(.subheadline)
                                                .bold()
                                                .opacity(0.8)
                                                .foregroundStyle(Color.purple)
                                                .padding(.leading)
                                                .padding(.vertical, 4)
                                            
                                            Text(item.floorPrice.unit)
                                                .font(.subheadline)
                                                .bold()
                                                .opacity(0.6)
                                                .foregroundStyle(Color.purple)
                                                .padding(.vertical, 4)
                                        }
                                        
                                        Spacer()
                                        
                                        makeLikeButton(item: item)
                                    }
                                    .padding(4)
                                    
                                    Button {
                                        showDetails = true
                                        navigationNFT = item
                                    } label: {
                                        Text("More Details")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.purple)
                                    .foregroundColor(.black)
                                    .buttonBorderShape(.roundedRectangle)
                                }
                                .frame(width:335, height: 410)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 4)
                                        .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                                        .opacity(0.5)
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.purple)
                    .background(Color.black.ignoresSafeArea())
                    .background(Color.black.ignoresSafeArea())
                }
            }
            .background(Color.black.ignoresSafeArea())
            .sheet(isPresented: $showDetails) {
                PriceDetailsView(clickedItem: $navigationNFT)
            }
        }
        .accentColor(.purple)
    }
    
    @ViewBuilder
    func makeLikeButton(item: NFT) -> some View {
        Button(action: {
            if favoriteItemList.contains(where: { $0.id == item.id }) {
                favoriteItemList.removeAll { $0.id == item.id }
            } else {
                favoriteItemList.append(item)
            }
        }, label: {
            Image(systemName: favoriteItemList.contains(where: { $0.id == item.id }) ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundColor(.purple)
                .frame(width: 25, height: 25)
        })
    }
    
    @ViewBuilder
    func makeNewListView() -> some View {
        
        NewListView(uiModel: .constant(makeNewListViewUIModel()))
        
    }
    
    func findNFT(nftname: String) -> NFT? {
        return nfts.first(where: { $0.name == nftname })
    }
}
    //#Preview {
    //    ContentView()
    //}
    
