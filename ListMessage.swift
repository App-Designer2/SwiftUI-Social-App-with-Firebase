//
//  ListMessage.swift
//  Chats
//
//  Created by App-Designer2 . on 26.01.20.
//  Copyright © 2020 App-Designer2 . All rights reserved.
//

import SwiftUI


struct ListMessage : View {
    
    var description = ""
    
    var Message = false
    var name = ""
    
    @Binding var image : Data
    
    @State var rating = 0
    var body: some View {
         
        VStack(spacing: 12) {
            //if Message {
                
                
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                
                Text(name)
                .font(.headline)
                .foregroundColor(.gray)
                Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.init("color"))
                    }
                }
                    Image(uiImage: UIImage(data: self.image)!).resizable()
                        .frame(width: UIScreen.main.bounds.width - 32, height: 260)
                        .cornerRadius(18)
                
                HStack {
                    ForEach(0...4, id: \.self) { star in
                        HStack {
                            Button(action: {
                                self.rating = star
                                
                                self.rating += 1
                            }) {
                                Image(systemName: self.rating >= star ? "star.fill": "star")
                                    .foregroundColor((self.rating >= star ) ?
                                        Color.yellow : Color.gray)
                            }.onTapGesture {
                                self.rating = star
                                
                            }
                        }
                    }
                    if self.rating == 0 {
                        Text("/5")
                    } else {
                        Text("\(self.rating)/5")
                        
                    }
                    
                    Spacer()
                    Button(action: {
                        
                    }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    }
                }
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            //}
        }
        
        //If you can find the github from this code on the description from my other tutorial called ( SwiftUI ChatApp with Firebase ( real time Messages )
    }
}
