//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/10/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postCommentCountLabel: UILabel!
    
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        postImageView.image = post?.photo
        postCaptionLabel.text = post?.caption
        postCommentCountLabel.text = "\(post?.commentCount ?? 0)"
    }
}
