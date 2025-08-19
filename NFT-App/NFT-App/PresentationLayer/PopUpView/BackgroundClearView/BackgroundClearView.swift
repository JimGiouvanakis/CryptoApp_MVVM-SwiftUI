//
//  BackgroundClearView.swift
//  Opap Online
//
//  Created by Theocharis Apostolidis on 11/11/24.
//

import SwiftUI
//
//struct BackgroundClearView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        
//        view.backgroundColor = .clear
//        
//        DispatchQueue.main.async {
//            view.superview?.superview?.backgroundColor = .clear
//        }
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {}
//}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

