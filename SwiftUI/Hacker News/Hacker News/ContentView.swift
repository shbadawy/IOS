//
//  ContentView.swift
//  Hacker News
//
//  Created by Shimaa Badawy on 10/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetweorkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts){ post in
                
                NavigationLink(destination: DetailedView(url: post.url)) {
                    HStack {
                        
                        Text(String (post.points) )
                        Text(post.title)
                            .padding()
                        
                    }
                    
                }
                
            }
            .navigationBarTitle("Hacker News")
            
        }
        .onAppear{
            
            networkManager.fetchData()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

