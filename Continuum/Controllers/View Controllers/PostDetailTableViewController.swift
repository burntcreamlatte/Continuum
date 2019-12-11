//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/10/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var followPostButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    // MARK: - Properties
    
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions

    @IBAction func commentButtonTapped(_ sender: UIButton) {
        presentCommentAlertController()
    }
    
    
    
    // MARK: - Helper Methods
    
    func updateViews() {
        guard let post = post else { return }
        postImageView.image = post.photo
        tableView.reloadData()
        //update follow button?
    }
    
    func presentCommentAlertController() {
        let alertController = UIAlertController(title: "Add a comment", message: "Go on, do it.", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Something funny here"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addCommentAction = UIAlertAction(title: "Add Comment", style: .default) { (_) in
            guard let commentText = alertController.textFields?.first?.text, !commentText.isEmpty, let post = self.post else { return }
            PostController.shared.addComment(text: commentText, post: post) { (comment) in
            }
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addCommentAction)
        self.present(alertController, animated: true)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        let comment = post?.comments[indexPath.row]
        cell.textLabel?.text = comment?.text
        cell.detailTextLabel?.text = comment?.timestamp.stringWith(dateStyle: .medium, timeStyle: .short)

        return cell
    }
}
