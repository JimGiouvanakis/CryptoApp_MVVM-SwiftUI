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
                        AsyncImage(url: URL(string: filteredNFTs[line].imageURL)) { result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding()
                                .shadow(radius: 50, x: 50, y: 50)
                        }
                        .aspectRatio(1, contentMode: .fit)
                        
                        HStack {
                            VStack {
                                Text("NEW")
                                    .bold()
                                    .padding(5)
                                    .background(.yellow, in:RoundedRectangle(cornerRadius: 10))
                                    .rotationEffect(.degrees(-30))
                                    .font(.footnote)
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

//#Preview {
//    NewListView()
//}
