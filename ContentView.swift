//
//  ContentView.swift
//  Chats
//
//  Created by App-Designer2 . on 25.01.20.
//  Copyright © 2020 App-Designer2 . All rights reserved.
//

import SwiftUI
import UserNotifications

struct Creater : View {
    @ObservedObject var message = DataFire()
    
    @Environment(\.presentationMode) var presen
    
    @State var name = ""
    @State var description = ""
    @State var image : Data = .init(count: 0)
    
    @State var show = false
    
    @State var alert = false
    var body : some View {
        NavigationView {
            VStack(spacing: 12) {
            if self.image.count != 0 {
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(uiImage: UIImage(data: self.image)!)
                        .renderingMode(.original)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                }
            } else {
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                }
            }
            
            TextField("Name...", text: self.$name).padding()
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(25)
            
            TextField("Description...", text: self.$description).padding()
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(25)
            
            
            
            
            //Start
            
            
            Button(action: {
                //Notification
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) { (noti, _ ) in
                        if noti {
                            let notification = UNMutableNotificationContent()
                            notification.title = "Notification"
                            notification.body = "\(self.name)"
                            
                            let triger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
                            
                            let reques = UNNotificationRequest(identifier: "notification", content: notification, trigger: triger)
                            UNUserNotificationCenter.current()
                            .add(reques, withCompletionHandler: nil)
                            
                            return
                        }
                        self.alert.toggle()
                }
                
                //Send data to firebase and firebase send to our app.
                self.message.addInfo(name: self.name, description: self.description, image: self.image)
                self.name = ""
                self.description = ""
                
                self.presen.wrappedValue.dismiss()
            }) {
                Text("Create")
                    .padding(10)
                    .foregroundColor((self.name.count > 0) ? Color.white : Color.black)
                
                
            }.background((self.name.count > 0 && self.description.count > 0) ? Color.blue : Color.gray)
                .cornerRadius(8)
            
            //End
            
        }.navigationBarTitle(Text(""),displayMode: .inline)
            .navigationBarItems(leading: Text("Add remainder"),trailing: Button(action: {
            self.presen.wrappedValue.dismiss()
        }) {
            Text("Cancel")
            }).foregroundColor(.white)
    }
        .sheet(isPresented: self.$show, content: {
            ImagePicker(show: self.$show, image: self.$image)
        })
    }
}

struct ContentView: View {
    
    @State var name : String = ""
    @State var show = false
    @State var image : Data = .init(count: 0)
    @State var description : String = ""
    var body: some View {
        NavigationView {
            VStack {
                Messagepage(name: self.name, description: self.description, image: self.$image)
                
            }.navigationBarTitle("Remembers", displayMode: .inline)//ZStack
                .navigationBarItems(leading:
                    Button(action: {
                        self.show.toggle()
                    }) {
                        HStack {
                        Image(systemName: "plus.circle.fill")
                            
                            Text("new")
                        }.foregroundColor(.white)
                    
                    
                }, trailing: HStack {
                    if self.image.count != 0 {
                        Image(uiImage: UIImage(data: self.image)!)
                    } else {
                        Image(systemName: "person.circle.fill")
                    }
                })
        //HStack
        }//NavigationView
            .sheet(isPresented: self.$show) {
                Creater()
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemRed
        
        let scroll = UINavigationBarAppearance()
        scroll.backgroundColor = .systemGreen
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = scroll
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
