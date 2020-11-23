//
//  CardView.swift
//  Mugiwaras
//
//  Created by Angel Daniel Alcudia on 18/11/20.
//

import SwiftUI

struct CardView: View {
    
    let character: Character
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(character.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Text(character.shortDescription)
                    .font(.body)
                    .lineSpacing(5)
                    .lineLimit(4)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: screen.bounds.width * 0.75)
                    .background(Color.black.opacity(0.7))
            }
            .frame(width: screen.bounds.width * 0.75, height: screen.bounds.height * 0.60)
            .cornerRadius(16)
            .shadow(radius: 4)
            
            Text(character.name)
                .font(.system(size:30, weight: .medium))
                .foregroundColor(.black)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(character: Character.stubbed[0])
    }
}
