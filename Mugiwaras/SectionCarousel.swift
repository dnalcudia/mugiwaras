//
//  SectionCarousel.swift
//  Mugiwaras
//
//  Created by Angel Daniel Alcudia on 23/11/20.
//

import SwiftUI

struct SectionCarousel: View {
    
    let section: CharacterSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(section.name)
                .font(.system(size: 20, weight: .regular))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(section.picturesImageName, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 125)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    }
                }
                .padding()
            }
        }
        .padding(.bottom)
    }
}

struct SectionCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SectionCarousel(section: Character.stubbed[0].sections![0])
    }
}
