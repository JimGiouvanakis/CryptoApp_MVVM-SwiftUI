//
//  SearchView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 29/11/24.
//

import Foundation
import SwiftUI


struct SearchView: View {
    
    @Binding var nfts: [NFT]
    
    var uiModel: [UIModel] {
        makeUIModel(nfts: nfts)
    }
    
    @State private var searchTerm = ""
    
    var searchFilteredNFTs: [UIModel]   {
         uiModel.filter { $0.name.localizedStandardContains(searchTerm) }
    }
    
    @State var filteredNFTs: [UIModel]
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                 
                Text("Search Tab")
                    .font(.title)
                    .padding(.trailing,250)
                
                TextField("", text: $searchTerm, prompt: Text("Search").foregroundColor(.purple))
                    .accentColor(.purple)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 4)
                            .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                            .opacity(0.5)
                    )
                
                VStack {
                    ForEach(searchFilteredNFTs, id:\.id) { item in
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: item.imageURL)){ result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                            
                            Text(item.name)
                                .font(.headline)
                                .bold()
                                .padding(6)
                            
                            HStack {
                                Text(item.floorPricePrice)
                                    .font(.subheadline)
                                    .bold()
                                    .opacity(0.8)
                                    .foregroundStyle(Color.purple)
                                    .padding(.leading)
                                    .padding(.vertical, 4)
                                
                                Text(item.floorPriceUnit)
                                    .font(.subheadline)
                                    .bold()
                                    .opacity(0.6)
                                    .foregroundStyle(Color.purple)
                                    .padding(.vertical, 4)
                                
                                Spacer()
                            }
                            .padding(4)
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 4)
                            .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                            .opacity(0.5)
                    )
                }
            }
            .onChange(of: searchTerm, perform: { newValue in
                filteredNFTs = searchFilteredNFTs
            })
            
            .background(Color.black)
            .foregroundColor(.purple)
        }
    }
}
//#Preview {
//    SearchView()
//}
