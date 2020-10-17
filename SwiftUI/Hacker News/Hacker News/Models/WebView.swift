//
//  WebView.swift
//  Hacker News
//
//  Created by Shimaa Badawy on 10/17/20.
//

import Foundation

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable{
    
    let url: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        if let urlString = url {
            
            if let url = URL(string: urlString){
                
                let request = URLRequest(url: url)
                uiView.load(request)
                
            }
            
        }
        
        
    }
    
}
