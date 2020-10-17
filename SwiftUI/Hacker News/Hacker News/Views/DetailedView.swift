//
//  DetailedView.swift
//  Hacker News
//
//  Created by Shimaa Badawy on 10/17/20.
//

import SwiftUI

struct DetailedView: View {
    
    let url:String?
    var body: some View {
        
        if let safeUrl = url {
            WebView(url: safeUrl)
        }
        
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(url:"https://google.com")
    }
}
