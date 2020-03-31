//
//  MessagePage.swift
//  Chats
//
//  Created by App-Designer2 . on 25.01.20.
//  Copyright © 2020 App-Designer2 . All rights reserved.
//

import SwiftUI

struct Messagepage: View {
    @ObservedObject var message = DataFire()
    var name = ""
    var description = ""
    @Binding var image : Data
    
    //@State var write = ""
    var body: some View {
        //VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(message.remembers) { i in
                if i.name == self.name {
                    ListMessage(description: i.description, Message: true, name: i.name, image: i.$image)
                } else {
                    ListMessage(description: i.description, Message: false, name: i.name, image: i.$image)
                }
                
                }.padding()
                
            }.navigationBarTitle("Remembers", displayMode: .inline)
            
        //}
    }
}
