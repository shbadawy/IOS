//
//  ContentView.swift
//  DiceUI
//
//  Created by Shimaa Badawy on 10/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDiceeNumber = 1
    @State var rightDiceNumber = 5
    
    var body: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("diceeLogo")
                Spacer()
                
                HStack {
                    DiceeView(number: leftDiceeNumber)
                    DiceeView(number: rightDiceNumber)
                    
                }
                .padding(.horizontal)
                Spacer()
                
                Button(action: {
                    
                    self.rightDiceNumber = Int.random(in: 1...6)
                    self.leftDiceeNumber = Int.random(in: 1...6)
                    
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .bold()
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                .background(Color.red)
            }

        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceeView: View {
    
    let number:Int
    
    var body: some View {
        
        Image("dice\(number)")
            .resizable()
            .aspectRatio(1,contentMode: .fit)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
