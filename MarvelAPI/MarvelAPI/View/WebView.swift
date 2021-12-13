//
//  WebView.swift
//  MarvelAPI
//
//  Created by Михаил Щербаков on 13.12.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
}
