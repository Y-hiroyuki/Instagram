//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 由上博之 on 2021/06/29.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPostData(_ postData: PostData) {
         //画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
         //キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let number = postData.comments.count
        self.commentLabel.numberOfLines = number
        if number == 0 {
            self.commentLabel.text = "コメントなし"
        } else {
            var a = postData.comments[0]
            for i in 1 ..< number {
                a = a + "\n" + postData.comments[i]
            }
            self.commentLabel.text = a
        }
        
         //日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        let likeNumber = postData.likes.count
         //いいね数の表示
        likeLabel.text = "\(likeNumber)"
         //いいねボタンの表示
        if postData.isliked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
}

