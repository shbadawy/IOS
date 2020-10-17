//
//  NetworkManager.swift
//  Hacker News
//
//  Created by Shimaa Badawy on 10/10/20.
//

import Foundation

class NetweorkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData()  {
        
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page"){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                
                if error == nil{
                    
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do{
                            let result = try decoder.decode(Result.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.posts = result.hits
                            }
                            
                        }catch{
                            
                            print(error)
                            
                        }
                    }
                    
                    
                }else{print(error)}
                
            }
            
            task.resume()
            
        }
        
    }
    
}
