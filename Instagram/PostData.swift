//
//  PostData.swift
//  Instagram
//
//  Created by 由上博之 on 2021/06/27.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isliked: Bool = false
    var comments: [String] = []
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        let postDic = document.data()
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let comments = postDic["comments"] as? [String]{
            self.comments = comments
        }
        if let myid = Auth.auth().currentUser?.uid {
            if self.likes.firstIndex(of: myid) != nil {
                self.isliked = true
            }
        }

    }
}
