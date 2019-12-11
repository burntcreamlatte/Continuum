//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/11/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit


protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}

class PhotoSelectorViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: PhotoSelectorViewControllerDelegate?
    
    // MARK: - Lifecycle Methods
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        photoImageView.image = nil
//        selectPhotoButton.setTitle("Select Photo", for: .normal)
//    }

    @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
        presentImagePickerActionSheet()
        //TODO; may need to remove
        //REFACTOR; IMAGEPICKER FUNC IN PHOTOSELECTOR
//        guard let photo = selectedImage, let caption = captionTextField.text else { return }
//        PostController.shared.createPostWith(image: photo, caption: caption) { (post) in
//            self.tabBarController?.selectedIndex = 0
//        }
    }
}
// MARK: - UIImagePickerControllerDelegate
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentImagePickerActionSheet() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Pick your pic", message: "Go on pick one", preferredStyle: .actionSheet)
        //use photo library for selected photos
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Pics", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        //use camera for selected photos, will not show up on simulator, use test phone
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Take your pic", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Nevermind", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //check to make sure image is there under the specified image, then change outlet properties accordingly
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = photo
            selectPhotoButton.setTitle("", for: .normal)
            //sending image to delegate to populate image to UIView in selector
            delegate?.photoSelectorViewControllerSelected(image: photo)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
