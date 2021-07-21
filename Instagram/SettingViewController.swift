//
//  SettingViewController.swift
//  Instagram
//
//  Created by 由上博之 on 2021/06/20.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text {
             //空文字のときはtrue
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "表示名を入力して下さい")
                return
            }
            let user = Auth.auth().currentUser
            if let user = user {
                 //ユーザーのプロフィールを更新する
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました。")
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }
        }
         //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    @IBAction func handelLogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        tabBarController?.selectedIndex = 0
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = Auth.auth().currentUser
        if let user = user {
            displayNameTextField.text = user.displayName
        }
    }
}
