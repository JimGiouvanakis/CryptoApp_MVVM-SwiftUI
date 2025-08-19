//
//  PopUpView.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 3/12/24.
//

import SwiftUI

struct PopUpView: View {
    //
    @Binding var isError: Bool
    @Binding var popUpHeadText: String
    @Binding var popUpText: String

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: isError ? "exclamationmark.triangle" : "person")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding()
                
                Text(popUpHeadText)
                    .font(.title)
                    .padding(10)
                
                Text(popUpText)
                    .font(.title3)
                    .opacity(0.7)
                    .padding(10)
                
                Button {
                    dismiss()
                } label: {
                    Text("Ok")
                        .padding([.leading,.trailing],70)
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.purple)
                .cornerRadius(8)
            }
            .frame(width: 315, height: 350)
            .background(Color.purple)
            .cornerRadius(12)
            .shadow(radius: 10)
            .foregroundColor(.black)
        }
        .background(BackgroundClearView())
    }
}

//#Preview {
//    PopUpView()
//}
