//
//  CommentViewController.swift
//  Instagram
//
//  Created by 由上博之 on 2021/07/08.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentText: UITextField!
    var postData: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        let name = Auth.auth().currentUser?.displayName
        let comment = "\(name!): \(self.commentText.text!)"
        let updateValue = FieldValue.arrayUnion([comment])
        postRef.updateData(["comments": updateValue])
        //let postDic = ["comments" : comment] as [String : Any]
        //postRef.updateData(postDic)
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
