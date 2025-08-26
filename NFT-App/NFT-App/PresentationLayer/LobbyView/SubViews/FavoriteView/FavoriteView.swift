//
//  FavoriteView.swift
//  TestApp
//
//  Created by Dimitris Giouvanakis on 10/10/24.
//

import SwiftUI

struct FavoriteView: View {
    
    @Binding var favoriteItemList: [NFT]
    
    @State var clickedItem: NFT?
    
    @State private var showDetails = false
    @State private var loginInView = false
    @State private var userStatus: UserLogStatus = .email
    
    var body: some View {
        NavigationStack {
            ZStack {
                if userStatus == .loggedOut {
                    VStack {
                        
                        Spacer()
                        
                        makeLogOutPopUp()
                        
                        Spacer()
                    }
                } else {
                    makeFavView()
                        .sheet(isPresented: $showDetails, content: {
                            PriceDetailsView(clickedItem: clickedItem)
                        })
                }
            }
            .onAppear {
                setStatus()
            }
            .navigationDestination(isPresented: $loginInView) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    @ViewBuilder
    func makeLogOutPopUp() -> some View {
        ZStack {
            VStack {
                Text("Sign In to get access to Favorites")
                    .font(.title3)
                    .padding(10)
                
                Button {
                    loginInView = true
                } label: {
                    Text("Sing In")
                        .padding([.leading,.trailing],70)
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.purple)
                .cornerRadius(8)
            }
            .frame(width: 320, height: 200)
            .background(Color.purple)
            .cornerRadius(12)
            .shadow(radius: 10)
            .foregroundColor(.black)
            
            Spacer()
        }
        .background(BackgroundClearView())
    }
    
    @ViewBuilder
    func makeFavView() -> some View {
            ScrollView {
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("My List")
                            .foregroundColor(.purple)
                            .font(.largeTitle)
                            .padding(.trailing,250)
                        
                        ForEach(favoriteItemList, id:\.name) { item in
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: item.imageUrl)){ result in
                                    result.image?
                                        .resizable()
                                        .scaledToFit()
                                }
                                
                                Text(item.name)
                                    .font(.headline)
                                    .bold()
                                    .padding(6)
                                
                                HStack {
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
                                    
                                    Spacer()
                                }
                                .padding(4)
                                
                                Button {
                                    clickedItem = item
                                    showDetails.toggle()
                                } label: {
                                    Text("More Details")
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.purple)
                                .foregroundColor(.black)
                                .buttonBorderShape(.roundedRectangle)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple, lineWidth: 4)
                                    .shadow(color: Color.purple,radius: 5, x: 0, y: 1)
                                    .opacity(0.5)
                            )
                        }
                    }
                    
                    Spacer()
                }
                
                .foregroundColor(.purple)
                .background(Color.black.ignoresSafeArea())
            }
            .background(Color.black.ignoresSafeArea())
    }
    
    func setStatus() {
        userStatus = AppViewModel.shared.userLogStatus
    }
}
