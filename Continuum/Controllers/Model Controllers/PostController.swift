//
//  PostController.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/10/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    static let shared = PostController()
    
    var posts = [Post]()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    func addComment(text: String, post: Post, completion: @escaping (Comment?) -> Void) {
        let comment = Comment(text: text, post: post)
        post.comments.append(comment)
        
        //TODO; finish completion with CK
        
    }
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let post = Post(caption: caption, photo: image)
        self.posts.append(post)
        //TODO; finish completion with CK
    }
}
