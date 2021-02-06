//
//  PhotoPickerViewController.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//

import UIKit

// MARK: - Protocol
protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}

class PhotoPickerViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var selectedImageButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: PhotoSelectorViewControllerDelegate?
    
    var contactPhoto: UIImage? {
        didSet {
            if contactPhoto != nil {
                loadViewIfNeeded()
                // If we have photo then we need the button with no title
                selectedImageButton.setTitle("", for: .normal)
            }
    
        }
    }
    
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageView()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectedImageView.image = nil
    }
    
    // MARK: - Actions
    @IBAction func selectButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
    }
    
// MARK: - Helper Fuctions
    func updateImageView() {
        self.selectedImageView.image = contactPhoto
    }
  
}

//MARK: - Extension (UIImagePickerDelegate)
extension PhotoPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = photo
            delegate?.photoSelectorViewControllerSelected(image: photo)
            selectedImageButton.setTitle("", for: .normal)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentImagePickerActionSheet() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
}//End of extension
