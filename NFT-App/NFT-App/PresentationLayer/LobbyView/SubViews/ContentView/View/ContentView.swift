//
//  ContentView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 3/10/24.
//

import SwiftUI

struct ContentView : View {
    
    // MARK: - Properties
    
    @State var viewModel = ContentViewModel()
    
    @Binding var nfts: [NFT]
    @Binding var favoriteItemList: [NFT]
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            self.makeMainView()
                .navigationDestination(isPresented: $viewModel.pushToDetails) {
                    PriceDetailsView(clickedItem: $viewModel.navigationNFT)
                }
                .sheet(isPresented: $viewModel.showDetails) {
                    PriceDetailsView(clickedItem: $viewModel.navigationNFT)
                }
                .background(Color.black.ignoresSafeArea())
        }
        .accentColor(.purple)
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    private func makeMainView() -> some View {
        VStack {
            ScrollView {
                
                NewListView(uiModel: viewModel.makeNewListViewUIModel(nfts: self.nfts))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
                
                Divider()
                
                HStack {
                    Text("Top Searches")
                        .font(.title3)
                        .padding(.leading)
                        .foregroundColor(.purple)
                    
                    Spacer()
                }
                .padding(.bottom)
                
                TopSearchesView(uiModel: viewModel.makeTopSearchViewUIModel(nfts: self.nfts), didTapItem: { nftname in
                    viewModel.navigationNFT = findNFT(nftname: nftname)
                    viewModel.pushToDetails = true
                })
                .padding(.leading, 8)
                .frame(height: UIScreen.main.bounds.height * 0.3)
                .padding(.bottom)
                
                self.makeMainSearch()
                    .padding(.top)
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
    
    @ViewBuilder
    func makeMainSearch() -> some View {
        VStack(spacing: 20) {
            ForEach(nfts, id:\.id) { item in
                VStack(alignment: .leading) {
                    
                    RemoteImageView(urlString: item.imageUrl)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    
                    Text(item.name)
                        .font(.headline)
                        .bold()
                        .padding(6)
                    
                    HStack {
                        HStack {
                            Text(item.floorPrice.amount.prefix(5))
                                .bold()
                                .opacity(0.8)
                                .padding(.leading)
                                .padding(.vertical, 4)
                            
                            Text(item.floorPrice.unit)
                                .font(.subheadline)
                                .bold()
                                .opacity(0.6)
                                .padding(.vertical, 4)
                        }
                        
                        Spacer()
                        
                        makeLikeButton(item: item)
                    }
                    .padding(4)
                    
                    Button {
                        withAnimation {
                            viewModel.showDetails = true
                            viewModel.navigationNFT = item
                        }
                    } label: {
                        Text("More Details")
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 4)
                        .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                        .opacity(0.5)
                )
            }
        }
        .padding()
        .foregroundColor(.purple)
    }
    
    @ViewBuilder
    func makeLikeButton(item: NFT) -> some View {
        Button(action: {
            self.makeFavList(item: item)
        }, label: {
            Image(systemName: favoriteItemList.contains(where: { $0.id == item.id }) ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundColor(.purple)
                .frame(width: 25, height: 25)
        })
    }
    
    // MARK: - Methods
    
    func findNFT(nftname: String) -> NFT? {
        return nfts.first(where: { $0.name == nftname })
    }
    
    func makeFavList(item: NFT) {
        if favoriteItemList.contains(where: { $0.id == item.id }) {
            favoriteItemList.removeAll { $0.id == item.id }
        } else {
            favoriteItemList.append(item)
        }
    }
}

#Preview {
    LobbyView()
}
