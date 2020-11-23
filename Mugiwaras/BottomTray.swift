//
//  BottomTray.swift
//  Mugiwaras
//
//  Created by Angel Daniel Alcudia on 18/11/20.
//

import SwiftUI

struct BottomTray: View {
    
    let selectedCharacter: Character?
    var isScrollDisable = true
    
    var body: some View {
        ZStack {
            if self.selectedCharacter != nil {
                VStack(spacing: 0) {
                    Rectangle().fill(Color.gray.opacity(0.4))
                        .frame(width: 40, height: 4)
                        .cornerRadius(4)
                    
                    Text(self.selectedCharacter?.name ?? "")
                        .font(.system(size: 30, weight: .semibold))
                        .padding(.vertical)
                    
                    Divider()
                    
                    ScrollView(showsIndicators: false) {
                        Text(self.selectedCharacter?.description ?? "")
                            .padding()
                        
                        if self.selectedCharacter?.sections != nil {
                            Divider()
                            
                            ForEach(self.selectedCharacter!.sections!) {
                                section in
                                SectionCarousel(section: section)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .disabled(self.isScrollDisable)
                    

                }
            }
        }
        .multilineTextAlignment(.leading)
        .background(Color.white)
        .foregroundColor(.black)
    }
}

struct BottomTray_Previews: PreviewProvider {
    static var previews: some View {
        BottomTray(selectedCharacter: Character.stubbed[0], isScrollDisable: false)
    }
}
