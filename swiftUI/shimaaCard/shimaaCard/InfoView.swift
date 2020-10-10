//
//  InfoView.swift
//  shimaaCard
//
//  Created by Shimaa Badawy on 10/10/20.
//

import SwiftUI

struct InfoView: View {
        
        let image:String
        let text:String
        
        var body: some View {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .overlay(
                    HStack {
                        Image(systemName: image)
                        
                        Text(text)
                            .bold()
                            .font(.system(size: 15))
                    }
                )
                .padding(.all)
                .frame( height: 100.0)
        }
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView( image:"phone.fill",text:"Hello" )
            .previewLayout(.sizeThatFits)
    }
}
