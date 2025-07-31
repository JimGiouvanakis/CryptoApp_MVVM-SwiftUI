//
//  URL+Extention.swift
//  NFT-App
//
//  Created by Dimitris Giouvanakis on 24/7/25.
//

import Foundation

extension URL {
    init(staticString: StaticString) {
        guard let url = Self(string: "\(staticString)") else {
            fatalError("Invalid static URL string: \(staticString)")
        }

        self = url
    }
}
