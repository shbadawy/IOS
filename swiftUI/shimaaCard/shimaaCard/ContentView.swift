//
//  ContentView.swift
//  shimaaCard
//
//  Created by Shimaa Badawy on 10/10/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        ZStack {
            Color(red: 0.18, green: 0.80, blue: 0.44)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(
                            Color(.white),lineWidth: 3
                        )
                    )
                Text("Shimaa Badawy")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                Text("Full-Stack Web Developer")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .bold()
                Text("IOS Developer")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .bold()
                Divider()
                
                InfoView(image: "mail.fill", text: "shimaa.mohammed.badawy@gmail.com")
                
                InfoView(image:  "link", text: "https://www.linkedin.com/in/eng-shimaa-badawy")
                
                
                
            }
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



