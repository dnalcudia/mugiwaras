//
//  ContentView.swift
//  Mugiwaras
//
//  Created by Angel Daniel Alcudia on 18/11/20.
//

import SwiftUI

let screen = UIScreen.main

struct ContentView: View {
    
    let characters = Character.stubbed
    @State var selectedCharacter: Character?
    @State var bottomDragState: CGSize = .zero
    @State var showFull = false
    
    let heightBanner = screen.bounds.height * 0.65
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Ellipse().fill(Color(red: 8/255, green: 16/255, blue: 54/255))
                    .rotationEffect(.degrees(90))
                    .offset(y: -screen.bounds.width * 0.7)
                    .edgesIgnoringSafeArea(.top)
                    .opacity(self.selectedCharacter == nil ? 1 : 0)
                
                VStack(alignment: .center, spacing: 24) {
                    VStack(spacing: 20) {
                        Text("麦わの海賊団")
                            .font(.system(size:36, weight: .bold))
                        Text("They are the main focus and protagonists of the manga and anime One Piece, and are led by the main protagonist, Monkey D. Luffy.")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:10) {
                            ForEach(self.characters) { item in
                                
                                GeometryReader {
                                    proxy in
                                    CardView(character: item)
                                        .rotation3DEffect(
                                            .degrees(Double(proxy.frame(in: .global).minX - 20) / -20), axis: (x:0, y:1, z: 0))
                                        .onTapGesture {
                                            withAnimation(Animation.spring()) {
                                                self.selectedCharacter = item
                                            }
                                        }
                                }
                                .frame(width: screen.bounds.width * 0.75, height: screen.bounds.height * 0.65)
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical)
                    }
                }
                .blur(radius: self.selectedCharacter == nil ? 0 : 50)
                
                ZStack {
                    Rectangle().fill(Color.clear)
                    if self.selectedCharacter?.imageName != nil {
                        Image(self.selectedCharacter!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: screen.bounds.width)
                .frame(height: self.selectedCharacter == nil ? nil : self.heightBanner)
                .offset(y: self.selectedCharacter == nil ? -screen.bounds.height : (self.heightBanner / 2) - (screen.bounds.height / 2))
                .opacity(self.selectedCharacter == nil ? 0.5 : 1)
                .blur(radius: self.bottomDragState.height > 0 ? min(self.bottomDragState.height, 50) : 0)
                .animation(.easeInOut)
                
                BottomTray(selectedCharacter: self.selectedCharacter, isScrollDisable: !self.showFull)
                    .frame(maxWidth: .infinity)
                    .frame(height: screen.bounds.height * 0.7)
                    .padding(.top)
                    .padding(.bottom, 32)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 24)
                    .offset(y: self.selectedCharacter == nil ? screen.bounds.height : screen.bounds.height * 0.5)
                    .offset(y: self.bottomDragState.height)
                    .gesture(DragGesture().onChanged({ (value) in
                        self.bottomDragState = value.translation
                        
                        if self.showFull {
                            self.bottomDragState.height += -300
                        }
                        
                        if self.bottomDragState.height < -300 {
                            self.bottomDragState.height = -300
                        }
                    }).onEnded( {(value) in
                        withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                            if self.bottomDragState.height > 100 {
                                self.selectedCharacter = nil
                                self.bottomDragState = .zero
                            }
                            
                            if self.bottomDragState.height < -200 || self.bottomDragState.height < -100 {
                                self.bottomDragState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomDragState = .zero
                                self.showFull = false
                            }
                        }
                    })
                    )
                                
            }
            .background(Color(red: 235/255, green: 235/255, blue: 227/255))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
