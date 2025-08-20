//
//  PriceDetailsView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 9/10/24.
//

import SwiftUI

struct PriceDetailsView: View {
    
    var clickedItem: NFT?
    
    var body: some View {
        
        if let clickedItem {
            ScrollView {
                VStack {
                    Spacer()
                    
                    Text(clickedItem.name)
                        .font(.largeTitle)
                        .padding(8)
                        .foregroundColor(.purple)
                    
                    AsyncImage(url: URL(string: clickedItem.imageUrl)) { result in
                        result.image?
                            .resizable()
                            .scaledToFit()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 4)
                            .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                            .opacity(0.5)
                    )
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            
                            VStack(alignment: .leading) {
                                Text("Name:")
                                    .opacity(0.5)
                                Text(clickedItem.name)
                                    .foregroundColor(.purple)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Slug Name:")
                                    .opacity(0.5)
                                Text(clickedItem.slug)
                                    .foregroundColor(.purple)
                            }
                            
                        }
                        .padding([.bottom, .leading])
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Total Supply:")
                                    .opacity(0.5)
                                
                                Text("\(clickedItem.totalSupply)")
                                    .foregroundColor(.purple)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Number of Owners:")
                                    .opacity(0.5)
                                Text("\(clickedItem.numberOwners)")
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding([.bottom, .trailing, .leading])
                        
                        VStack(alignment: .leading) {
                            Text("Floor Price:")
                                .opacity(0.5)
                            Text("\(clickedItem.floorPrice.amount) \(clickedItem.floorPrice.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        VStack(alignment: .leading) {
                            Text("Floor Price of One Day:")
                                .opacity(0.5)
                            Text("\(clickedItem.floorPriceOneDay.amount) \(clickedItem.floorPriceOneDay.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        
                        VStack(alignment: .leading) {
                            Text("Floor Price of One Week:")
                                .opacity(0.5)
                            Text("\(clickedItem.floorPriceOneWeek.amount) \(clickedItem.floorPriceOneWeek.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        VStack(alignment: .leading) {
                            Text("Volume of the Day:")
                                .opacity(0.5)
                            Text("\(clickedItem.volumeOneDay.amount) \(clickedItem.volumeOneDay.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        VStack(alignment: .leading) {
                            Text("Volume of the Week:")
                                .opacity(0.5)
                            Text("\(clickedItem.volumeOneWeek.amount) \(clickedItem.volumeOneWeek.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        VStack(alignment: .leading) {
                            Text("Best Collection Bid: ")
                                .opacity(0.5)
                            Text("\(clickedItem.bestCollectionBid.amount) \(clickedItem.bestCollectionBid.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        VStack(alignment: .leading) {
                            Text("Total Collection Bid Value:")
                                .opacity(0.5)
                            Text("\(clickedItem.totalCollectionBidValue.amount) \(clickedItem.totalCollectionBidValue.unit)")
                                .foregroundColor(.purple)
                        }
                        .padding([.bottom, .leading])
                        
                        Spacer()
                    }
                    .foregroundColor(.purple)
                }
                .background(Color.black)
            }
            .background(Color.black)
        }
    }
}
//
//#Preview {
//    PriceDetailsView(clickedItem: mockDataForView)
//}
