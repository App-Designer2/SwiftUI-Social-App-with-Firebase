//
//  DataFire.swift
//  Chats
//
//  Created by App-Designer2 . on 25.01.20.
//  Copyright © 2020 App-Designer2 . All rights reserved.
//

import Firebase
import Combine


class DataFire : ObservableObject {
    @Published var remembers = [iDData]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("remembers").addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges {
                if i.type == .added {
                    
                    guard let name = i.document.get("name") as? String else { return }
                    
                    guard let description = i.document.get("description") as? String else { return }
                    
                    guard let image = i.document.get("image") as? Data else { return }
                    
                     let id = i.document.documentID
                    
                    self.remembers.append(iDData(id: id,name: name, description: description, image: image))
                }
            }
        }
    }
    func addInfo(name: String, description: String, image: Data) {
        let db = Firestore.firestore()
        
        db.collection("remembers").addDocument(data: ["name": name, "description": description, "image": image]) { (err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("Success")
        }
    }
}
