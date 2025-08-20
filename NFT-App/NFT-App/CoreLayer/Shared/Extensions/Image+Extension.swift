//
//  Image+Extension.swift
//  CryptoApp_MVVM-SwiftUI
//
//  Created by Dimitris Giouvanakis on 20/8/25.
//

import Foundation
import SwiftUI
import Kingfisher

extension Image {
    
    
}

struct RemoteImageView: View {
    let urlString: String
    
    var body: some View {
        
        KFImage.url(self.makeUrl())
            .resizable()
            .placeholder {
                ProgressView()
            }
            .fade(duration: 0.25)
        
    }
    
    func makeUrl() -> URL? {
//        let string = "https://\(BaseURLEnum.musicRoutes)/mr_be_serve/\(urlString)"
        return URL(string: urlString)
    }
    
}
