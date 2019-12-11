//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/10/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {

    // MARK: - Properties
    
    var selectedImage: UIImage?
    
    // MARK: - Outlets
    
    @IBOutlet weak var captionTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    
    //REFACTOR; POTENTIAL NN
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    //REFACTOR; POTENTIAL NN
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captionTextField.text = nil
    }

    // MARK: - Actions
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let photo = selectedImage,
            let caption = captionTextField.text else { return }
        PostController.shared.createPostWith(image: photo, caption: caption) { (post) in
            //sn; mnn
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
}

// MARK: - PhotoSelectorViewControllerDelegate
extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        selectedImage = image
    }
}
